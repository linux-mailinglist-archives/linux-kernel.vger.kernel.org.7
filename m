Return-Path: <linux-kernel+bounces-759226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012F2B1DA8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65293AF26F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D8262FFC;
	Thu,  7 Aug 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0y1MiVC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7781758B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579203; cv=none; b=FqjnfszEg+R/RyZLxfuKy9kl8lZ41fcQRsvwrkjKp5zmUZU7QVzGp/MC1yhHfD2vbWJAdvhYhj+Qo/vn0GE/r/Iq9utm334KgID3VT53w8xZyf+RnIF4NrNlulaKIcuarUFGjciMnus7WqeT7z/AlZitOigdHMZzyi9PNfeGP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579203; c=relaxed/simple;
	bh=KWAwu8mTVMdPPfIZrxk84kZ/gXNb5qn2N9/fwgssNmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCoL73cA6ctZdKwI5Ra2X007efXx1g+yM3fmEUbMOqVXS069RaI/zY5wGGUmLe+qyY3NWcRav6nPfy/9Z3EKsWF4aCr1nLRnyqvRsvtAiRWJomhrkbR2bLM/4Nw4P2PTCn8h5u2rIwzJVNJnWoeMWkTeSIdHxI0XecjOInB97F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p0y1MiVC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so7524015e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754579200; x=1755184000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6O+WjOVwwbRSzuBkX7hK/Nu0/m6vyOZpY9eTPj6cgU=;
        b=p0y1MiVCJkdRS9Jb58npdFW+LQzdHbJBk4DxexomJ8V3LXtElCretBN0jyjigedjAt
         UE5toMZUp0SAoM6zEzFKBVlzNtEHgZi+nG6WYTKRLHyk8VDuNP/zbyll5R4c3Us0nxAT
         3oWPP5dtKIIzLuq6LTjAKZx1EgfeJORBk3xKdyjtV6Hyircu9JshvLHmqyUHDJ+AK3M7
         6huRXJLTLrrO4rz1eZADSKuzrytIvjsMTO49x6ZAkMyWOEabVqVIglruHENyFAyi64aX
         kEjZEaNNJwgeCeeQQoxlNA8Xye9gOUugoxbx28p8cbTKFDb+N5tSmpHRTucKFdPIF/b+
         9ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754579200; x=1755184000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6O+WjOVwwbRSzuBkX7hK/Nu0/m6vyOZpY9eTPj6cgU=;
        b=SQMdxUIS562BUcOP6CrmwlDlgM0QfuFzq/pMMRmTQouJPk2Zrlyc5WQyQrixA/f3LH
         S9y+5Hl+x5Gjd0Eqr1gN8Wsc/3lnJ1i+vCI3ooct49AOTaIVVMR1S2OzvL7h7PspolXt
         ct8Fk2g3zvPIucm2F0llza9d+3B/MBpsy49HEr1vz3shflIlINX/sLl9dFSZhkkCxoIQ
         hME+tsWbNlJgCpyZTkj6yJNE+5/25CYcuayaFwwicmvAu/htbp83q9e0guZC3nLuN6oV
         tXnmQFWfdRM4bkN0kaeKlkfuWYIWttw3/j4k/44KOFmzkG1nytTBDGr/UpofxCvvPnl5
         qkTw==
X-Forwarded-Encrypted: i=1; AJvYcCUv9oHY1TPEzsiEmsw6CmleeO4C/LRTmu4Uhv0opejLPo2Ygg5SVYAsznD7NfE0/oyRM5DIyUyaprN+uWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdLrYBEKxL2ETV9HXDtJfMiveseKO6kk0Tm4kIvDpramlYNDd
	Rakqjzbj4sRdjMmiLZQCaOR1euf5bOFmuEv+0Eoi2leg6VKAvrsXPup3kaSehIUCWNo=
X-Gm-Gg: ASbGncsFTAjhjdN2UrVgkGO35Z3ae/JyqRftJ8uFBBDfZMWRG0pqD45bY17ZrWddb8L
	xGBzr6OZJ4pjyLV64indqd7ifg1sb6Sk0U+xh9BxRSAKazlyG/sH9P3kr4ccyTH9FdJAE6jvyWR
	SLgWrgdzK+2do0eEYtY9E3aidjbKo8hSq/6agBUVAQtBp4RAtMkEP925JmASEHh7nhfXv31sK0f
	44DWkMCL7ktHNligWPlPoN30rgJOwP/AQy7fZc5DiaEQnuWXOQo9JEHS1oWtzaNQDIrmVAAmom1
	RHdIRa5sJapiX0GRSblSkgGWiVXPKN1kcFkLzq0arr2muPhHqKBmRNTq/SbRqIBYlxAroIqWaZF
	STzS0LWGQVp/kNuh3US2rv5WPlYkMfvS8
X-Google-Smtp-Source: AGHT+IGjIsP2g6wrTvZaWmu8QWXif/PcYC9alr889oh03nXHWut6TZmp+hykrZBgMf3fNHXOlmvGYQ==
X-Received: by 2002:a05:600c:1d25:b0:456:1904:27f3 with SMTP id 5b1f17b1804b1-459ee85db8bmr34043395e9.18.1754579199576;
        Thu, 07 Aug 2025 08:06:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58553f8sm104158965e9.14.2025.08.07.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:06:39 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:06:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: Using smatch and sparse together (Re: [PATCH next] smb: client:
 Fix use after free in send_done())
Message-ID: <ffc54288-5986-4505-b77f-bd800cc45527@suswa.mountain>
References: <aJNASZzOWtg8aljM@stanley.mountain>
 <ad2e9d94-2d95-4351-b800-627f20672209@samba.org>
 <87646c67-78b8-41c5-9b72-361cb3b733d1@suswa.mountain>
 <e291d925-bfd9-4202-b5d4-de5bf30ab870@samba.org>
 <a1a0046c-f47f-4e8a-ae3c-85db58a6cb2f@suswa.mountain>
 <df4905fb-933e-4055-8363-d6427515773b@samba.org>
 <d3b63d25-1b03-4c7c-85cc-efd9d74c3a8a@suswa.mountain>
 <aa65df64-68f1-47bb-ab69-9817387f3ab8@samba.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa65df64-68f1-47bb-ab69-9817387f3ab8@samba.org>

On Thu, Aug 07, 2025 at 04:27:41PM +0200, Stefan Metzmacher wrote:
> > The DB is too big and too dependent on your .config but I should
> > share the smatch_data/ more regularly.  I started to push that into
> > a separate git repo but I didn't finish that work.  I should do
> > that.
> 
> Ok, what's the gain of updating it?
> Does it help when doing fixes on old kernels?

If you run smatch_scripts/build_kernel_data.sh then it runs
smatch_scripts/gen_* which generates a bunch of the files in
smatch_data/.  Which in theory should enable more warnings for new
code.

I've been moving away from generating files and more towards
putting everything in the DB.  I just took a look at the files now
to respond to your email and what I saw wasn't good...  I need to
look at this some more.

I don't know how often the zero day bot rebuilds the smatch_data.
I bet they never do and so I think it doesn't really matter.

> 
> I'm typically doing a full kernel build a week after each rc.
> My idea was to rebuild the whole db after doing that.

Yeah.  That's a good strategy.  The data from the existing DB feeds
into the new one when you rebuild the DB so don't delete the old
DB at the start or anything.

regards,
dan carpenter


