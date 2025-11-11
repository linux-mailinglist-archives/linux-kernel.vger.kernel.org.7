Return-Path: <linux-kernel+bounces-895066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 621BAC4CD78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 204FF4FBD33
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69792FE58F;
	Tue, 11 Nov 2025 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b="jAVEIDGR"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689F2FE06B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854869; cv=none; b=n6+T0O72QQ/ZVACxHD52pjsxiqIvJA6XgUIYNGkwIE20iEdArD938VuHDbukV8Z7rydUyiCmiVGjM3Ddw+JAHC4tUU4rKsY03a5yiwH/c7vly4fVbebUnB61aWIkrf/0NZROjpLA6mzHBqGsle8jVK3sRk9LioMWWWiOkPaQ3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854869; c=relaxed/simple;
	bh=EJdDjhImozdW7IdZ3kTSU704p4CBNXhkKy5TYb/uSeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsZqMDlC1CT+jQBEEl0PrhK0Arc6sA94qAl3UcBfJMy9syOL2tP8auHWtDRKdH3WWlZT921o/1YNgP1bnVjaFiQTm8A3puILSinRHZXjs5I3DD2g8wyA77ZvVqADslLH1b1KqoSsrAmN6wCYyuiu8/L4c0BsJqGIFNYjXjPSKJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b=jAVEIDGR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ba599137cf8so527344a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chenxiaosong-com.20230601.gappssmtp.com; s=20230601; t=1762854865; x=1763459665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hk5BFBpp1u5WXCaMFe/o0o3qPx8QHj09GEzO1frMoAw=;
        b=jAVEIDGRoyOB9XFdPDTChAzx/d1Ov3XPcFHCRBibPJ7YTyQC8W19t7PMUk8jOolvq+
         DyfXJ9PMFgJQNo3qB99uYrvMXqGBpeWTdyLIrvVP87U6n+zBJGFPr6xa1h3P6CWVOZfo
         c78v96VLVQts7jAonx4wh8QZMHDN9igzCMvIu3QZxTUIKAZpHR/nPFN7huh20w803+Dc
         wtQ4sWnyGieGULVL7S6cqGMuv9Pd1pLdZxVEc7wgJILQ9aJ2B2bOXIp0rkxKN5Qy+BXt
         d8xptEpyb4AnvAx5JZ4uXnPV41s59k7upRzxPTpqnj13soSA0zyh8hlLtqnF/kWP2Qaq
         wuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854865; x=1763459665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hk5BFBpp1u5WXCaMFe/o0o3qPx8QHj09GEzO1frMoAw=;
        b=lSj86bDQFAwLYQWRmfK/1FQwIIJ4uds7ghSlFQSV2CdkW19Fu1NAZk8L5FQJuQb73S
         bRBCT0IBfK9DibspUTou5y6T5Lr1scBGWbksZSUVUbubQEgH6VP3M8L+3MhUKvf68zpo
         HP/Dz3hgY4YbKEqeQ+sYkG/Egs2PfDli1QgUNC7IyinxdZkOcJbrFlc45ONbbrUXqbkH
         IaVczRzClwL9G7DnwM+BviOtlolLz2eJ8TpMKl16jaeibGXAfCXnPh6ti6Im4PlFG/fN
         KvZZkX36yJHq8n303pHDsUTQ/A3ILdrvJJHjRDoweiJNtuNI5jBgXhCxvwYsoeNvdFoM
         iAzA==
X-Forwarded-Encrypted: i=1; AJvYcCWmWCw52gaXH8AQbpsM0bhJe2QBYYacTatJ6+UmwwfYI/vmPL0Fdn45H9rxUkasp9p22XmRMmBxg41ym50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcJ/Ektx2s5KfpdphkD3nRz3XGqrowj8DnyBfF9BvM1bQ3I18
	ZTP5KV1JC5iZidBgtZQfdbccUhgqPE7RRLLavQRWfjfa668yDDc5yNO7lOK15nZXJFrd
X-Gm-Gg: ASbGncswgjqPsqQTo3a1YAOEDKplV1ZOyRwcrvifSYXdnFeqQbrIIYNU+EBD/L1CDoR
	P0W230A7GWuptMLFxTvtrLRS+XfK+wS+HV5ePxtQ5ukruwJSLfY0OF4hUGAE6aNeDeGhLxGAqsS
	k69BcEXA0NDV/i8xHKDB4FAWH21pAF0m0sQxpiKjKVZ2ddy70f1gCC8uYCKoEeFALnavvOg6qZk
	s+p82Rpsk48sr5OCR2SLtx/h9gFqgSIyhf7dQR6f+wpX829vKePzNkWDRmXIzKJflc3DWhX4Oym
	LrLF5qNwdPhIwPmT26dnCjqxVq5D03tMFDyybsPXsGy4CVj8hZ98/MvG5AvXCR9VGMR/71m/fsM
	Bmb8BSpmlnwdkAbbVK4/5h2ehRgQENj7Mf4k64cbisdxMmz7LhwXSQzDjSpBbsbTbvAHO3yA5MC
	ExazpyVlYu7aSR+AWZ2rnDWElBdf0tpw==
X-Google-Smtp-Source: AGHT+IGicarsuDwLnGTWT91xUJNjECmoMxmxNsfpkxfNWnuZbEKbG6ntUwD1I5H+OPspzqZw01jytg==
X-Received: by 2002:a17:902:f785:b0:297:dd99:ff13 with SMTP id d9443c01a7336-29840842ef6mr38141055ad.17.1762854864631;
        Tue, 11 Nov 2025 01:54:24 -0800 (PST)
Received: from [192.168.3.223] ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29846334db5sm8225685ad.32.2025.11.11.01.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 01:54:24 -0800 (PST)
Message-ID: <a7809257-9125-4e08-80c5-8c7a22b6207b@chenxiaosong.com>
Date: Tue, 11 Nov 2025 17:54:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] smb/server: fix return value of smb2_notify()
To: sfrench@samba.org, smfrench@gmail.com, linkinjeon@kernel.org,
 linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
 ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20251017104613.3094031-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251017104613.3094031-3-chenxiaosong.chenxiaosong@linux.dev>
Content-Language: en-US
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20251017104613.3094031-3-chenxiaosong.chenxiaosong@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve and Namjae,

https://chenxiaosong.com/en/smb2-change-notify.html

The link above is my analysis of the change notify feature, and my 
progress on developing this feature will be posted at this link. This 
link will remain permanently accessible.

I will complete the implementation of this feature as soon as possible.

Thanks,
ChenXiaoSong.

On 10/17/25 6:46 PM, chenxiaosong.chenxiaosong@linux.dev wrote:
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> 
> smb2_notify() should return error code when an error occurs,
> __process_request() will print the error messages.
> 
> I may implement the SMB2 CHANGE_NOTIFY response (see MS-SMB2 2.2.36)
> in the future.
> 
> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> ---
>   fs/smb/server/smb2pdu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> index f80a3dbb2d4e..5b5f25a2eb8a 100644
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -8787,7 +8787,7 @@ int smb2_oplock_break(struct ksmbd_work *work)
>    * smb2_notify() - handler for smb2 notify request
>    * @work:   smb work containing notify command buffer
>    *
> - * Return:      0
> + * Return:      0 on success, otherwise error
>    */
>   int smb2_notify(struct ksmbd_work *work)
>   {
> @@ -8801,12 +8801,12 @@ int smb2_notify(struct ksmbd_work *work)
>   	if (work->next_smb2_rcv_hdr_off && req->hdr.NextCommand) {
>   		rsp->hdr.Status = STATUS_INTERNAL_ERROR;
>   		smb2_set_err_rsp(work);
> -		return 0;
> +		return -EIO;
>   	}
>   
>   	smb2_set_err_rsp(work);
>   	rsp->hdr.Status = STATUS_NOT_IMPLEMENTED;
> -	return 0;
> +	return -EOPNOTSUPP;
>   }
>   
>   /**


