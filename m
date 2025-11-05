Return-Path: <linux-kernel+bounces-886642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF01C36250
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 803F84F3D72
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E56423185E;
	Wed,  5 Nov 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZbuh3Ex"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613232192EE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353996; cv=none; b=M9XbT7suD8gm7p0Nm1A87n1Sy/v4sF/A2DO3ynKVpbV9iGI5Kwigfbuv8u8aoKMM3v6ShOqtzkyWzw23COj2Dqm8wB/Msdov0/z5wIrtHeUQiUyVGcgg3PFkJwNBWsbZ8Av6qSdRs9SzQeYlG4IFKx27ltjB+VF7UNkh6GZ3DC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353996; c=relaxed/simple;
	bh=7GHF9drscydM8VlSDyNkUaIR6HtQ621NPbVjDAEzaSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzp9U4IGWBSF3IaqLVrUQxD57EmmvzfnbuAemOZNp5OWION/LWyUrg1VbbY253NHMHkV9tEqsCTrde0ZfhS5g5GUEU5rEx8ZorhJrnZFB3LfmVr+YnAmlAINcOQywZtTxgynuDEOo1tkU5GZQtBVUbjO2kPMVS8Qb2TmW0I8Xi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZbuh3Ex; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso11367357a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762353993; x=1762958793; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=85Bq0egfrxZA4M7BAnfcstD/897TxaHcMzubb+eabQs=;
        b=pZbuh3ExC8u9Jl0lPGk2PRkA00uwak+9effgeATqsXYZvSUT5DV32vkC2bAAeeFxnv
         PqSIk1nxZatKONSaQnG44xo2RvTcQgYMewqWbHIGjqqk0xiKWy7XDhK5qFRq1R+SpGaa
         56pYuoXtwjWjiEWtYjH27LPIH8ghTQpKRYb/rk3qpQxEqSjj0/mj1hdLvICmmtGIX365
         PKw+0Vp6hhjrChHdpDMTlYnT8k9U0ugMZNo/YQAdMUG7IlFjl6h6rwyTEJwb+Lsx4ocZ
         NGX+pYUL/HPVKLfB/SUdSWtIrUymcwGsrjAkLfiacPKzbHmyqXaX++qZ9ZImHdQGc4cu
         Mr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353993; x=1762958793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85Bq0egfrxZA4M7BAnfcstD/897TxaHcMzubb+eabQs=;
        b=BOQCc+mzb4IAFNeVAYqT6nravz3Cy62/xJxLX+eLHZR+deTwTudM8J4tVJVVq8N726
         fcSLudLjUUlCfDcbo5uHHxiWmiCae5tb1NAvfjuurcLm6nvjk6OyczyMHyq+0tfHoohw
         978SpnAdIU87Zn0bj6QGBcVDffdbB8/p3aYj6nQKkBPQDasWkjDEwtGSIYNZeH/lXga7
         kVTD0AIl1aA/Nu2KWyz2posucJzP15RmqZGxKfnxpC4AZ/Fxh0tgXvy7hdSWEoXMtSFX
         8nqxvNuHpi6BzF2GLzDb//IRH4sUit1Yf9kQVjyfNssJdXEhPccs63keNCiICKzCp3Ov
         PSUw==
X-Forwarded-Encrypted: i=1; AJvYcCXDzMmcmj2/W5V5nvkk2c79dPU40zEUqvahezTOaCWGaMzuU15MHPbHm1EV5NHnV7fcks5CTB/56vWeSKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwRXdUwBMGaqCnswfH9vEm7xe0kCAkBlXv99s7t+pRw3VAzM2
	b9TJZcWIXl68rPzpVyFGVrTcgDRGuhgFZcorKT93ovQnhk0bvnc6672rBhgdb7dkEfw=
X-Gm-Gg: ASbGnctxWPF17uL8zAPlV/bxafQlftyU9y6QXu8PdnFNHbmXrNgSnIxHgKnGxaNlWlI
	JzS3pSUSUPgJ9DSczwiCSm9LmF4TYQd2K8xeV5agl6rAeZFKD6O0PX09jbR+N0BUp4SZfQ2wXh4
	itiQQGQ2M3RQFdaIOX17u1TgH9yI+/JfRX/18lVZwuUenjI4XA8t1ef+bL8qSBNKbt6SW9qLDih
	jCHIwqeC6g7tj+ZrW3cIyuHmC5dy5q5ZYxHNr9jUyQ9YAKwNVzTcFdxQuqE21yPBVVPy7XXJvbM
	a75Qi30/D8A8lBz1lg11f++ftLSuPs8GdmtSJTomeBajB9qyWvfO8qjcxDJtcmgahnXYms85oQw
	MEL/yQtBBrx+lTJjXHDEi54MswQfNsdGXywFVP91w7cpiVHPyXowmI+nyJlul87KitbJF7J1eMS
	/9FJbBjst7mGr4
X-Google-Smtp-Source: AGHT+IGXiYMjE4MZ4KaJmY+QgVHdNn4HEJ2OJAx5eUeCXhhwUT8sSEarGObVX+Ze2HK1oicnld1HEw==
X-Received: by 2002:a17:907:3f9a:b0:b54:8670:7c2d with SMTP id a640c23a62f3a-b7265682a9bmr338995866b.55.1762353992648;
        Wed, 05 Nov 2025 06:46:32 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e06e2sm539356766b.40.2025.11.05.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:46:32 -0800 (PST)
Date: Wed, 5 Nov 2025 17:46:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ally Heev <allyheev@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fix uninitialized pointers with free attr
Message-ID: <f6592ccc-155d-48ba-bac6-6e2b719a5c3e@suswa.mountain>
References: <20251105-aheev-uninitialized-free-attr-scsi-v1-1-d28435a0a7ea@gmail.com>
 <6d199d062b16abfbf083750820d7a39cb2ebf144.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d199d062b16abfbf083750820d7a39cb2ebf144.camel@HansenPartnership.com>

On Wed, Nov 05, 2025 at 09:21:45AM -0500, James Bottomley wrote:
> On Wed, 2025-11-05 at 19:44 +0530, Ally Heev wrote:
> > Uninitialized pointers with `__free` attribute can cause undefined
> > behaviour as the memory assigned(randomly) to the pointer is freed
> > automatically when the pointer goes out of scope
> > 
> > scsi doesn't have any bugs related to this as of now, but
> > it is better to initialize and assign pointers with `__free` attr
> > in one statement to ensure proper scope-based cleanup
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes:
> > https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
> > Signed-off-by: Ally Heev <allyheev@gmail.com>
> > ---
> >  drivers/scsi/scsi_debug.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> > index
> > b2ab97be5db3d43d5a5647968623b8db72448379..89b36d65926bdd15c0ae93a6bd2
> > ea968e25c0e74 100644
> > --- a/drivers/scsi/scsi_debug.c
> > +++ b/drivers/scsi/scsi_debug.c
> > @@ -2961,11 +2961,11 @@ static int resp_mode_sense(struct scsi_cmnd
> > *scp,
> >  	int target_dev_id;
> >  	int target = scp->device->id;
> >  	unsigned char *ap;
> > -	unsigned char *arr __free(kfree);
> >  	unsigned char *cmd = scp->cmnd;
> >  	bool dbd, llbaa, msense_6, is_disk, is_zbc, is_tape;
> >  
> > -	arr = kzalloc(SDEBUG_MAX_MSENSE_SZ, GFP_ATOMIC);
> > +	unsigned char *arr __free(kfree) =
> > kzalloc(SDEBUG_MAX_MSENSE_SZ, GFP_ATOMIC);
> > +
> 
> Moving variable assignments inside code makes it way harder to read. 
> Given that compilers will eventually detect if we do a return before
> initialization, can't you have smatch do the same rather than trying to
> force something like this?

This isn't a Smatch thing, it's a change to checkpatch.

(Smatch does work as you describe).

regards,
dan carpenter


