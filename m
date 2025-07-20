Return-Path: <linux-kernel+bounces-738295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEB3B0B6DD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A561899333
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156A921FF39;
	Sun, 20 Jul 2025 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="XtQTbhsV"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0831F0E53
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753027894; cv=none; b=IB5hKwGwIhB2omUbh/GzAF31w1And7aygsCvZLwkVyQ6rOPb8UhAUDJ3YRHUBnP3IwKaW5Uo6Mylf+0kaWVCJ+K3Jqog+gvGc2kqActzocxdd/maO+ntDa4nAAd+1IAdwaUpeOmDOqiKcBvZ40AKvfjke/rt4tDw98b8zoWW+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753027894; c=relaxed/simple;
	bh=1kkgAJedVRmqE+NjlLS/JrjnCCyYksp2IzhgSl3fYFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5T1x+HuK1SxqwbkPt0+H0ADoOOPmxsXGiaT1UqPXUqlcM6Vs3y07M8oiP7nyphxVgFhpVDxhpE67iChCcGxVl78Mww3nzVUYmsSb4rnFJuaUmjsZqYK+7Cut5GgkglKNEFucjThVNEaN6rRdA+RLPQky0nmj1ZKfdY706YbIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=XtQTbhsV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fba9f962so3207452b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1753027893; x=1753632693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3sE27/WAqZP41FkkjgAc8UwvwE9+GItC8A+pDEL148=;
        b=XtQTbhsVB/YmaMFMLuKs0K9dxI9bTaAbSr2oTdREH6vCWRbo3p+beRPlq4o2rItFxC
         4kbk2Tm0d3lj+avtfo+bKjEO7Q28DWvECd90S6hIzd605Tk5TRapJGipGaDRt/0tP0gs
         Bl23b7I+D+A04VKDzGi/sSMIVCQw+mbLQwjeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753027893; x=1753632693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3sE27/WAqZP41FkkjgAc8UwvwE9+GItC8A+pDEL148=;
        b=Z9e4o8HFqeNX8cRJ8e0GKCCM59fZuR6Fw6CWhZIj4qAkeVhceQLR7jsOOEepVq0X0m
         8/m67KmyKcE4wLSlEK2RYPMyxbs0HFgG0lRRx5CXYMai41lm/13+kxxa60yx0Ka6o82P
         gBPw8HN20kWtDSuJfJpOtya3VO+6NiG0DT2S/SSikwRJwfqABniRTlmPIrpa8e4kEmE2
         RNi87qUx/CCMDkERxLeV72HwyydME9rSEQOsiXjYTsF+O1cdPyYtGPwBkQxn7Wx5eEco
         puesKY0IqrIZsCT3mG+LGCqYPhcxfeUpCMxmZrZzxOGQET23QoD1jJ1e7sO51VIAesbw
         zMfw==
X-Forwarded-Encrypted: i=1; AJvYcCUY0W2avTOCoQAOItG0ZDRLFhNG6UIv7e8XX7YgB6/JpycQfLRVmn9ZeRK49+Zt8NV6DBuiyJXqhzgEztk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBH6uo0SZK7ZBUwkdZtpOsv1yFyJoBIm6UXJ6ZJ1MRgKjMPyue
	N2+P7jFnNzCTHk9lLhDrc6/pAoTAXqhDVs33f0Z/ZgCQMpIyEAHEWaECjCjOp6b1g+U=
X-Gm-Gg: ASbGncuK2vZC68OrA0eeM+vh7CMnNgTb/uCWfHEOgsDee1VD8I0C/62eXRUj/Wo8yj9
	EuBRvUySijUo2Y6yiCvglqa5fwQjMcv2nF+Yv/aKFyAg7E7lg/WsGqdnGbCElQju1GNO7ljG4cd
	tc1oJ4H3irg2IadlVFzEh8CDySQcFKlgLc0dQjYzvSh7jryGukch9mn3XYYEambXrk2CosXwuwa
	kWMzj+hfjopofw89vNbwzggSxMXMfHfPdtyXQSqe/jT///oNDCb0ydcI1l5qD1IbN/srgX4uOeq
	4kGBNen3IJv6Bc4yq9WeBWHG/zcpXxcJiS6CoZW5MGkPmrG4d5bgdthn87XhUhdXijpgge1RrQ+
	abFabKLe87ES3L4RUFZ/t58dIOAsA6ZNi5OUc4M1jDkh+wITMUzG04eP75A==
X-Google-Smtp-Source: AGHT+IFF1fTWCOr6/BH6HO2z3c4L025UX0QqK8oCHrmmePFPB5CppScDYdz+haI97RiMoMTtOxzo2g==
X-Received: by 2002:a05:6a00:3e15:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-75836faac4emr20252321b3a.3.1753027892574;
        Sun, 20 Jul 2025 09:11:32 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c8acb61csm4358217b3a.64.2025.07.20.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 09:11:32 -0700 (PDT)
Date: Mon, 21 Jul 2025 01:11:26 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [RFC PATCH 0/4] rust: miscdevice: abstraction for uring-cmd
Message-ID: <aH0VLhYptH_Sw0Py@sidongui-MacBookPro.local>
References: <20250719143358.22363-1-sidong.yang@furiosa.ai>
 <a0a868ef-107e-4b1b-8443-f10b7a35aabb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a868ef-107e-4b1b-8443-f10b7a35aabb@kernel.org>

On Sat, Jul 19, 2025 at 07:03:24PM +0200, Danilo Krummrich wrote:
> Hi Sidong,
> 
> On 7/19/25 4:33 PM, Sidong Yang wrote:
> > This patch series implemens an abstraction for io-uring sqe and cmd and
> > adds uring_cmd callback for miscdevice. Also there is an example that use
> > uring_cmd in rust-miscdevice sample.
> 
> Please also add Greg, maybe get_maintainer.pl does not list him, since the
> entries for miscdevice were missing for a while I think.
> 
> For new abstractions I also recommend to Cc the RUST reviewers.

Thanks for a advice. I've added Greg, and other RUST reviewers to Cc. 

Thanks,
Sidong

> 
> Thanks,
> Danilo

