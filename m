Return-Path: <linux-kernel+bounces-837726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C9EBAD0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD2616E45E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647B303C9D;
	Tue, 30 Sep 2025 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GLto13CZ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2545E1F428F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238570; cv=none; b=Ew6l3auT4x95NY3SOrPll/QHShJK1buglpUB2C28yEO41Qn25lOaQCN3KB1HldfpMzVd+EzKbN7i8ZhKElsEGAnKx7kTZJLRVs1D6OqmTuGMrPT/Ks7AmROANZLgFvoSdO636wrwknaO8+O40kYeb04b7/ov0knhDYH49ExtjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238570; c=relaxed/simple;
	bh=59NoSC7ocZ7c3HpMjXdvCeJv9n5mEh9jzMeOC/NIuGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHb77ua9t+S/O2LjMVy0ju+RUnEyiuiLOeqHn4hsIbM+o8MSOgVtItev/vojD2qHUeAJLgr2aqcnw4Wt/BNxZQA9taJhvqk958JrhwzF1NszjSi16pNOxHle0cxM50LIs0nWWWfSM+nBySHEwk4nJQPudngIN21EjEIUw1kPfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GLto13CZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso8155027a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759238566; x=1759843366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwAebk43If0gjy3ve3r9IFpSG2OftYAndV3V+n10Lek=;
        b=GLto13CZ6JMPlbvF/OCZ1TS1hOu/R8r+b+/yz6gY66gKmBqG5gWKjN+dU/LD/dUd2k
         iD3D4dM7F/qWwyae1v5YMx02CWMds4vqkX2NPQMLL3baHcFwVs3kQ306pfFkgWehdEUY
         Yu+8IE6nDs/DDBI8jgwI2UY9aIVSQp7+Slh/sXtLFuU+G5g/ZMU1PiV220vNnXR2IGSH
         OHBYi0XP6TbxPyLCtGoPvAgfIhBjYaSMGu+2b1n+YeFePcbP/FhtWnBiUo8FiVhZJTuT
         drkHDHAn9/e8XXNhTEkEbel0vnAdiKOtnk3Ic/Kim9zKjQV2WwUAg1dHPJrO2AKugJ96
         Rf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238566; x=1759843366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwAebk43If0gjy3ve3r9IFpSG2OftYAndV3V+n10Lek=;
        b=G7bFrdB4Cr42f4e2TC5GLt39M/hgL3zC2WuFazM4LMizEp42pKJGvP14yyfq0B+6eb
         px/4daNIWOJ9NT7+yt+xs3jGkll23YPUPN3F7zquNByemqOinC/9IZSxm++8A7to78Y+
         SAdM4/DSdIpcy2HfBzevNzUUln71aw+itl1qIeMhP6UCiKHl+n8nWkZCQ7LjicOXdYQa
         x/2VAwmT1pQDYeIuZ0VvfQyJmMsXV7+qOoWm+rn+FIVXuK44jquiK1M4Mu7UmsHQTnn8
         gl0BST9YcGkV1S1gKEGtMf8Y9tALRRLKk/mQTR3x5575SjYxk93US0nuCN8BLdQym0AP
         61cw==
X-Forwarded-Encrypted: i=1; AJvYcCUok78rdb0bnkk2/I/ieew1o/qfJ+ulSRT5Q9fkkL8BhdpxLTd1bbKGb+Bj3PiijD+qb3ocZUJKUZvY0Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZp8jkHt5cbXbU91URGeXfgxl5ZubZavapv1QkpOFEDa8kogIm
	+/sN36bRYOSRyEC8kEwzAniAK5VAr9qQ5U4d0Z/ToJ2yNzsus4wFluJJgFFH3A14sHc=
X-Gm-Gg: ASbGncsIUYoybpc0DngJxvt182HB61mN+UCPIIPoSjehK0y2p0ghkZO/k0ttKlMJ53d
	pTy+n3Sf3VvjTgD6wWiHFu2rn0rz6vwAio+2VeRsNtZ7mCsFPkO83fUbBGoJ5v+79GKvwsFB1+J
	SHBupkCVRtLpKgoytiFt7JA+52F89Lzagdiw6EBvze+fVZ47S4TvABDgLiHAUBCWVhUiBpVVthe
	/3pDS7iZCsXbl8AbTfIrFfXHyKvVVwMxYwnWQU+BdzhsZGQNFctKoftX/HATWk6piFw7PXKG/vM
	T7Zh4pacjv8uiwCJHlCAww7jcusatPyBnS+mM4jzDXdU1HfjeR/Uhj7b4vtLuAoM8/82LorCxQR
	pDzb3aOTHI3IiwWa/NGxzVQnhzO7SHNT6zBMUta+UI7TAwTnO2vAvtgLo0lVxPgwxswH3NSPyBZ
	XTAPhFUImTbWCtSKgaUpSvu80=
X-Google-Smtp-Source: AGHT+IGMmebQvklxeUJZNswwjRqyuzOfwdDvXkiArUTNHu/zyJ1G1AIYldRx7ek+Ug5wpdnFDX7cug==
X-Received: by 2002:a17:906:c150:b0:b04:6fc9:f108 with SMTP id a640c23a62f3a-b34b86a19b0mr2094007966b.24.1759238566474;
        Tue, 30 Sep 2025 06:22:46 -0700 (PDT)
Received: from ?IPV6:2001:a61:13a9:ac01:423a:d8a6:b2d:25a7? ([2001:a61:13a9:ac01:423a:d8a6:b2d:25a7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3b0c9c9e8esm686349166b.59.2025.09.30.06.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 06:22:46 -0700 (PDT)
Message-ID: <6c65094e-81e5-4ce8-8592-9458c51116f7@suse.com>
Date: Tue, 30 Sep 2025 15:22:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix urb unmapping issue when the uas device is remove
 during ongoing data transfer
To: guhuinan <guhuinan@xiaomi.com>, Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
 Yu Chen <chenyu45@xiaomi.com>
References: <20250930045309.21588-1-guhuinan@xiaomi.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250930045309.21588-1-guhuinan@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 30.09.25 06:53, guhuinan wrote:
> From: Owen Gu <guhuinan@xiaomi.com>
> 
> When a UAS device is unplugged during data transfer, there is
> a probability of a system panic occurring. The root cause is
> an access to an invalid memory address during URB callback handling.
> Specifically, this happens when the dma_direct_unmap_sg() function
> is called within the usb_hcd_unmap_urb_for_dma() interface, but the
> sg->dma_address field is 0 and the sg data structure has already been
> freed.
> 
> The SCSI driver sends transfer commands by invoking uas_queuecommand_lck()
> in uas.c, using the uas_submit_urbs() function to submit requests to USB.
> Within the uas_submit_urbs() implementation, three URBs (sense_urb,
> data_urb, and cmd_urb) are sequentially submitted. Device removal may
> occur at any point during uas_submit_urbs execution, which may result
> in URB submission failure. However, some URBs might have been successfully
> submitted before the failure, and uas_submit_urbs will return the -ENODEV
> error code in this case. The current error handling directly calls
> scsi_done(). In the SCSI driver, this eventually triggers scsi_complete()
> to invoke scsi_end_request() for releasing the sgtable. The successfully
> submitted URBs, when being completed (giveback), call
> usb_hcd_unmap_urb_for_dma() in hcd.c, leading to exceptions during sg
> unmapping operations since the sg data structure has already been freed.
> 
> This patch modifies the error condition check in the uas_submit_urbs()
> function. When a UAS device is removed but one or more URBs have already
> been successfully submitted to USB, it avoids immediately invoking
> scsi_done(). Instead, it waits for the successfully submitted URBs to
> complete , and then triggers the scsi_done() function call within
> uas_try_complete() after all pending URB operations are finalized.
> 
> Signed-off-by: Yu Chen <chenyu45@xiaomi.com>
> Signed-off-by: Owen Gu <guhuinan@xiaomi.com>
> ---
>   drivers/usb/storage/uas.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
> index 4ed0dc19afe0..6bfc7281f7ad 100644
> --- a/drivers/usb/storage/uas.c
> +++ b/drivers/usb/storage/uas.c
> @@ -699,7 +699,9 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd)
>   	 */
>   	if (err == -ENODEV) {
>   		set_host_byte(cmnd, DID_NO_CONNECT);

Why then set the host byte unconditionally?

> -		scsi_done(cmnd);
> +		if (!(cmdinfo->state & (COMMAND_INFLIGHT | DATA_IN_URB_INFLIGHT |
> +				DATA_OUT_URB_INFLIGHT)))
> +			scsi_done(cmnd);

It would seem to me that in this case you need to make sure
in the completion handlers that scsi_done() is always called,
even if the resetting flag is set.

	Regards
		Oliver


