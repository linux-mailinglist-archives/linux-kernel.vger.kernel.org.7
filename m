Return-Path: <linux-kernel+bounces-876613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE37C1BFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD4FE5A6258
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BC53375C3;
	Wed, 29 Oct 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqQJSL0c"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC3329C52
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753536; cv=none; b=F3xZAB4WUwinMcic1rKToz0eFlGOG0eeQxEdwawdeIbZIXMhQIL6BGj3vtJeWr8dLPnHMvObKK6POREqu/hB0THfh+G6tS/QNaUFTDd3mTx9yiCJNR23auNbvhlh3sC68XIN1psVGWOpNLEfc8G+LwBn21d4HB7IuG7qRC/r9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753536; c=relaxed/simple;
	bh=tPzwOV7GvDpR5Xi6HBtXCUHPQBBKe8WKMdp/yKCjpiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mB/Q0W2cUtUMAEKOjuFQnhsqH6z+U4siRgjVPTjgUw4ID4MDuYOgtG1R3bTfZ8m2EWKpW1OpqMq0NDMTIEJIfuAe4Bj+YGa309Xo5GBnnQ4k/Q/es7gzx6ht4tHsdj2hSTmo9Ax/8oUNBEtlZVeZcyBJNYiBE7/sAWV4gtzD8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqQJSL0c; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so63235b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753534; x=1762358334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwxrExpiKXBKK+ITlQ6foefTYgM8fnPgsDyzvsZJuN8=;
        b=dqQJSL0cde3zct34IDioKcpml5cSDJiX5DBjAXwMS5+O10h9VSDCTp231V+o50yaHa
         /pEAmUzsxxh0yxU+NO+wQ3YMejdtnq+unVXWVITg+SnfBTmen5K1jQo1W4MMi4xda/+f
         U70SeIvuGan9MrlgMezrcsrJm4XJ1mVPtSrP74v4SfvvJi+dBeLA0Df7kNbKD5MHrOYk
         Tg9f0qZEzUsFJmrzc5WO7JJ9iBqwgRt0+nffaBMkQP2+CPCzyDdzH5d6jf8NY1csfH8z
         nZOVk1Gy8393qfno8c+cUaa0d+LWBpMMOKnw2PWD+LIlcNz09xwfhvrrpAXrjvqMzsOf
         nR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753534; x=1762358334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MwxrExpiKXBKK+ITlQ6foefTYgM8fnPgsDyzvsZJuN8=;
        b=V2krAHJ3ybyjqsnz7IvyhoDcirU99SMMW1EwIC6C5ZTVCEtc9tBtAqwx/2L7rKKTBY
         Nodf8+pNxtdRwYTVQ8+EQ/aiDBpjFWbMVk/M4bxAfs+xgEg/f1nJYkLngbczbJjVB04A
         1IykhAZ3ON6/QY/EIpumcXwOTVNhF+LMLoGCkvRsKbLXC1MPDwZyhtDYSFEW7CvTx/r4
         kTo01lf1s9xUh4GCcYqeM1RVAcec/v4W50lRIe+K0l8JiRujA6nT5Q7gBj1tWx3urpnM
         oxoGcmm9napn6aT2EUoiUWafZVGmgVYmz06+JmXGlZUm6qYNQcb/YKIgdGKKSOBVjvty
         SLUg==
X-Forwarded-Encrypted: i=1; AJvYcCVGo8LVCWTXkx4+9FJpUDpj+u/Sri2nMzUboQoSgr05ktYo/NrBYSyjCXG6CaBPI0J3cfncvFDOt3UWmvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYjweDe6pDj/G1RbXIRsk/SAWeqypT+PWqDhaHeqTCY5wA/9h5
	nJGx0FipB83NqYmNx8Uj6psz3+h30s91g+Xiexrl2XgrjrBhwo/uW8gO
X-Gm-Gg: ASbGncsTj8ETeuBMSlIuwbHGW7io0ayqJDWKnOoF6TF5eW4+GI0D4ygszNtGadWTf1R
	4I9y7IZcg3uhECtZtz8Mw7/L7e/IMHjo859fQnBZnCwSEJoNuSR2XxVaIDshhe1FoAHkHD8KX+X
	sM8R+DkxxXvNZrpF6fhnOWKOeuQ21yfET2yBfk6TmE1ZFl0wtnT8TeZlEmpZjibb/5xaGueCKLc
	+/q8uKwQm1gXguzs3fSKlaWt+MbriNaKP3zr0lpTWKFT0rXKz8Vvb5Ut4qNU7LBf1uFACoRaPpn
	qhUH+Ty4IuTs4owkyc/Cv1ZpzE0vGjzF7OQELziFzcC17sY37sz3PeLKWhm9wpAiM1vTvySjLva
	yAGk7x2gpGsXGop4rrq/VBBTMFcEwa6biOsmiQ2l/Alx49qjigp7O/FH9uM1X/r49Ol0iUMw9i5
	2jW/oIXxUK1MWm0nEacwx0TqoZMWaJxw+DTrQ226l6jbchOnI6VaiE3Ns+0Y+00+Oq47JM11tih
	+o0hgdyK2s1xizy8SqPd6aNXC0StKPqSNAJnXdsIP+OWl+deOMJclN6nmC0P6QaAjnP
X-Google-Smtp-Source: AGHT+IEDUOVYU4FbtZmNjoIisTx8ifKNOJtO/21KsW1AgRzDGmjWuA4/mf+B5T+NZ/lyYpe4qwFN0Q==
X-Received: by 2002:a05:6a00:7589:b0:7a5:396d:76af with SMTP id d2e1a72fcca58-7a5396d7d19mr2988818b3a.18.1761753534501;
        Wed, 29 Oct 2025 08:58:54 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:8b41:6bc3:2074:828c? ([2a00:79e0:2e7c:8:8b41:6bc3:2074:828c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414069164sm15874564b3a.45.2025.10.29.08.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:58:54 -0700 (PDT)
Message-ID: <ea07dede-5baa-41e5-ad5d-a9f6a90ac6e8@gmail.com>
Date: Wed, 29 Oct 2025 08:58:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
To: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-block@vger.kernel.org
References: <20251029071537.1127397-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20251029071537.1127397-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 12:15 AM, Christoph Hellwig wrote:
> we've had a long standing issue that direct I/O to and from devices that
> require stable writes can corrupt data because the user memory can be
> modified while in flight.  This series tries to address this by falling
> back to uncached buffered I/O.  Given that this requires an extra copy it
> is usually going to be a slow down, especially for very high bandwith
> use cases, so I'm not exactly happy about.
> 
> I suspect we need a way to opt out of this for applications that know
> what they are doing, and I can think of a few ways to do that:
> 
> 1a) Allow a mount option to override the behavior
> 
> 	This allows the sysadmin to get back to the previous state.
> 	This is fairly easy to implement, but the scope might be to wide.
> 
> 1b) Sysfs attribute
> 
> 	Same as above.  Slightly easier to modify, but a more unusual
> 	interface.
> 
> 2) Have a per-inode attribute
> 
> 	Allows to set it on a specific file.  Would require an on-disk
> 	format change for the usual attr options.
> 
> 3) Have a fcntl or similar to allow an application to override it
> 
> 	Fine granularity.  Requires application change.  We might not
> 	allow any application to force this as it could be used to inject
> 	corruption.
> 
> In other words, they are all kinda horrible.

Hi Christoph,

Has the opposite been considered: only fall back to buffered I/O for 
buggy software that modifies direct I/O buffers before I/O has
completed?

Regarding selecting the direct I/O behavior for a process, how about
introducing a new prctl() flag and introducing a new command-line
utility that follows the style of ionice and sets the new flag before
any code runs in the started process?

Thanks,

Bart.

