Return-Path: <linux-kernel+bounces-744632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8EAB10F63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1539A1CE56AB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66CD2EA754;
	Thu, 24 Jul 2025 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="RTcZwWK0"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC5285CA6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373137; cv=none; b=awS0sAPS0BT8RCVQPdOpcZ3+FyV0HHEy9sdkQ5M+Qn3GdfaezfAy9AtuJOaPqWq7DcVpyfC2R9fgk9JrCFaYni/W7G2oJ+LT/dVh7tkbUEQo7Y8ttkI5CSt171dzpO0Elqv7cG2jorIDzqdZCfvyVOmVl4XvClCJHR4pdI54zyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373137; c=relaxed/simple;
	bh=0VUcTAlTKI8Uut+YrFJ9JnFPeuS1MyI+ehjEzU6u9SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQyq+GMgUN/1tF8iPVbdTZc5aGECZyHKXybxKEnCksfspPM5YYIAWxlUQepTgngvEyDq90jbVN6wqNU5+tqj8/FgMokQihYKnUiBxnt26SPuTARoAEZH6FVJ+W24dYdTHREVgQNASl/EKRnkfxzBvD099Y7nlHDKjAT4wfDyPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=RTcZwWK0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23649faf69fso9952225ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1753373132; x=1753977932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPrDAQdM9SEh1PC8EgiE1RAI5sFJN3A+tD++JaDKFmM=;
        b=RTcZwWK08KSyMDVKrfSebH8hoeuDIYUlw5feYTyayOgg2QYqwsMAVXlRuzUHzT0gGa
         zh97hlaBLZd6JXnHS0NFBzg6Rph+ttaux0ByZIzet+MyJ9aSITzw04sUx4UlSlA2FSim
         GofF3h7y09FlPRUGLA0dt1gPfICTmVsgF8I/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753373132; x=1753977932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPrDAQdM9SEh1PC8EgiE1RAI5sFJN3A+tD++JaDKFmM=;
        b=AOmoCB6c/dubBsLBEDMal98+ZgDQqimzg8CabbW54e7Ged2skX6GXAYGg3Bcq1MCDM
         qzLh8TqkuNKXork5fRyPKjUjd3jdBO9ZCYOkn7C7uvQ5k+aoEFIzgLT8TwEIk+gUAL2N
         rOd5f/vrelarv1f1R3Cp8rWH5tXcbxLMADzj9Z25ft4VZ/mOydsv3cUXXX+HG9my4uCI
         Q0jQACWwA8rwRaZDeKc4701SbT8p/Q72TK0SsiaPbGnMbKceWOTqp2dzq9HRECZWMRav
         suPpLVvHLDZjnO2x6VDhu1AqK/Smg06jIxIgmc57sJEiYTeOlLvSt5zU3YDOdBXLxRAM
         CjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUPE0aLjmcrzd79ImxT3Ed3XVTbRZ68jsrmk1EAtU/j0p/5E4FQZv8TVPjujp/vBsD0e07ZAjYrKS4HrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlljGRECLy39f0Nse8DWAi6DuwHE2l5ujfohOpK9Cc9D4R0nf3
	4z9jgmcc+FGfAfHGPUoUvBo60YD1SMMAGpTaa1raIkgSs8+MAQn10CSSrhEQIRc26vM=
X-Gm-Gg: ASbGncs0eTllOM9iexgAqbmQr68jGHCQfUMhR4tN2rmtLkaMitZiCEEoB88ETSoDi0r
	ZMChVM+qDQFj5HSS02BaYBJApAhk9gFCGDUC4mWSG/rtQxzw9zAaaOY6fFDpehnMiYmMXMSyJFB
	Okq0sQkjRMi6CP+s55Zk4izv7/BzaMxu5FpBNQ4PAuV6r3Ji8KedAbB9nU4i5hKdXsQOnQNCAHH
	vJ2A5ePij1uxjzkXeLbBusAWJh5KhX2qV4WqU6Eme9ACSxttbn2sfhGuZNRW8jeMyBidgap1Ap7
	mTSL4K4DM4Km+muWVRJpXL68WDOZJO9SzvcrO2cJ4gddnrp5wXjJB6ZKQXDd69fj2eksymyxH1h
	6TYJapbl66CHy71SN9j3HVH+GDL/XugRAWWMbYKiC2OzQ+PD0hGSRGuoS
X-Google-Smtp-Source: AGHT+IFOb7VV+hEvYr5JMOJR9pYJzMfOIn04UMDsdukQyZlKdVzKoT94AbgXvi68H4CvfhuA1xh5ag==
X-Received: by 2002:a17:902:d2ca:b0:234:8c64:7885 with SMTP id d9443c01a7336-23f981efd84mr99141955ad.53.1753373132037;
        Thu, 24 Jul 2025 09:05:32 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f3d3sm18905165ad.40.2025.07.24.09.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 09:05:31 -0700 (PDT)
Date: Fri, 25 Jul 2025 01:05:10 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Benno Lossin <lossin@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: io_uring: introduce rust abstraction for
 io-uring cmd
Message-ID: <aIJZthYtM4e7-E4v@sidongui-MacBookPro.local>
References: <20250719143358.22363-1-sidong.yang@furiosa.ai>
 <20250719143358.22363-3-sidong.yang@furiosa.ai>
 <CADUfDZoBrnDpnTOxiDq6pBkctJ3NDJq7Wcqm2pUu_ooqMy8yyw@mail.gmail.com>
 <aH3OsKD6l18pLG92@sidongui-MacBookPro.local>
 <CADUfDZrLKrf6evTXQ03cJ1W4kj0gxsF9Bopu+i2SjkBObXKnMA@mail.gmail.com>
 <aH5g-Q_hu6neI5em@sidongui-MacBookPro.local>
 <DBHVI5WDLCY3.33K0F1UAJSHPK@kernel.org>
 <aH-ga6WdOpkbRK3T@sidongui-MacBookPro.local>
 <DBIT6WL2C5MG.2J7OBX6LCVYP7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBIT6WL2C5MG.2J7OBX6LCVYP7@kernel.org>

On Tue, Jul 22, 2025 at 08:52:05PM +0200, Benno Lossin wrote:
> On Tue Jul 22, 2025 at 4:30 PM CEST, Sidong Yang wrote:
> > On Mon, Jul 21, 2025 at 06:28:09PM +0200, Benno Lossin wrote:
> >> On Mon Jul 21, 2025 at 5:47 PM CEST, Sidong Yang wrote:
> >> > It's safest to get NonNull from from_raw and it returns
> >> > Pin<&mut IoUringCmd>.
> >> 
> >> I don't think you need `NonNull<T>`.
> >
> > NonNull<T> gurantees that it's not null. It could be also dangling but it's
> > safer than *mut T. Could you tell me why I don't need it?
> 
> Raw pointers have better ergonomics and if you're just passing it back
> into ffi, I don't see the point of using `NonNull`...

Agreed, from_raw() would be called in rust kernel unsafe condition not in safe
driver. Thinking it over, using a raw pointer would be convenient.

> 
> >> > from_raw() name is weird. it should be from_nonnnull()? Also, done()
> >> > would get Pin<&mut Self>.
> >> 
> >> That sounds reasonable.
> >> 
> >> Are you certain that it's an exclusive reference?
> >
> > As far as I know, yes.
> 
> So the `IoUringCmd` is not refcounted and it is also not owned by the
> `done` callee?

Yes, io_uring_cmd would be allocated in io_submit_sqes() and it's not accessed
concurrently. io_uring_cmd_done() sets its result to io_uring_cmd and prepare
some field to completion.

Thanks,
Sidong

> 
> ---
> Cheers,
> Benno

