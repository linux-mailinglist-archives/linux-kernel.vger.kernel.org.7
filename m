Return-Path: <linux-kernel+bounces-845804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C72BC6228
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08461407CC4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594242BEC3A;
	Wed,  8 Oct 2025 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HVPH0jon"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF0F1F462D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943981; cv=none; b=sWdhqMrSZaglVEXlSUGR81pxM+SpTQ7W2EjEq4LpfN1SXYXi6bq6X+E6b67zCXM8m5Ki5ul/0C4nvJmJxetGyArbtOHuWYE8XMfLxh69SkQ3mQWaU3JoOFgCS44iv+o+GrtPYh7x6hUiY2rQpDi+vfj9CcK2SDsiqDgxGa5VzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943981; c=relaxed/simple;
	bh=SjTTUUPBnlmnWR5xPYR0CfI/lFRVIEQr/hjyFEOR+zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1P/ejM4PYenRBSUcWGxNqBQeAY3KjyFtOyeaeK+KrIS+F1vLSw26uV/Cy1AA1zgfZb0C8LjbbwDP3gXLhy14uiaiic/Ri1lqpE03JPEsqxnMUTgsPQyLzt2VbK92g2BKl3MgB86qEByuXtmOEZPK7ecRNeRwYdAgLGgx5+PxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HVPH0jon; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42420c7de22so91236f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759943977; x=1760548777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pyuxM1qJujrcTe93h+cZ4UxFH6Em2UfoKr73Xc2DaU=;
        b=HVPH0jonUlnlICW/SdtoHwAeMjO9OD5X6D+NKQgsV9A5pzaVRJ6zFb2H6fkI9URidW
         3tOUzVdlvPIvHtTLts59JWZvTFgC0URj3tlguxbMjFtbOXwNl0kAdTfWijGIz2i49SFw
         cpOaCwO8XRCakH7i5fKtECAMVseHSUwJV9QlRxmeSEhMfWhBKL5zoRrln1vtTrndydCd
         i1wPLWJ4xBm6wMi/5qvFSojnBU+3S6XhVUQpHcLKuTF7yhvXjNmSJvsYigfJIKs+nSLB
         XZmPQMQCwiRDs0xc0bMmCoZ8o5+RTdhuNRCAunHUwmCX3ye6JdhUd2TOHkc9tvBQ2BdM
         Y3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759943977; x=1760548777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pyuxM1qJujrcTe93h+cZ4UxFH6Em2UfoKr73Xc2DaU=;
        b=DttuWnIUSlyaE+vUaMSgHxCpbSzQ8Pm+VMA4l3wO8868xCryldR6TkVH1GbOfhWV7R
         jXLZk7OrJZJ5vDHHH2naxVWC2Dd0StYLQTgErS9RFGBjD+vQF/XtzLVxkvLR/EvDROV+
         GqzU5NPFAfoiS229yq2B6SO/lUzUs0uNDYbbPKxvH/b5iX5Kvt1x1nhGrVR1JX8SMOdB
         6xeCwr4jFFn1gx7b8cUEnHILp5RUpLsC22XQ2rRd/OoeYrKIbPs8JLz+3oYNyT+fvEux
         fUBc14lDI6cwaIca4PoBf1Dv1OVUvH/tLoAFyDnMkmfGmXjzIW2jvwB6ZyDQnocgd329
         fcjg==
X-Gm-Message-State: AOJu0YwQLizNNc00PDFoxreuxEIyxxtljC9PZKu338JXf8xNgQVEP2b9
	CZu8oysx1SutPfwkA8tXJ9Ly1odnM91RWousAg1+V/lq/gzgEICjJVDpdZ1a4OC0kvA=
X-Gm-Gg: ASbGncuusEbATtnHr4VkL5zVeXirLm2Vkq1UCmtclZ4OUuBxkdpggacHSpsVPT/2Cbq
	uQw69RMM2MOnT40kveRkOGzENGVLqzasqKYbiULQnqsyaYdBTINgbkm5XMsZ/xx4g5SAlV70VKo
	2Pkc049Susu+KBAPiO8WMEH/uxV3RBZ0NMLgUTFlQ/LRth4GSf+8Q0dlgNGPUkvFjR7eFSvwqbU
	LRhePN9f0icVQE/r30NqR5qqTxEMjAjIxqbMXS6HJ9sf+OWsozGQEHREQI39oZiht2R274CRlSo
	uKJBX9XqHcqYdrYvRMrYY1o6xAiLSeczMKJ8TWFDC5PtFDnU4DgD6GA3I53CSBnZQiKOzfJa6Wt
	5509k0IO40yRAEnGru5Fu2VoKRiGofQbvWzfLPiX32OchepHn5Wpuc6mzkDPCMlTGahlBYjj+/C
	uDX4gHw4jyOZvLnC2ZGPUacZ9CtQgsAVLY4kUQLg==
X-Google-Smtp-Source: AGHT+IGwV2IWGY48tJXj7XfE/oEPofnleR/8SAfmD8lIPiCmMhG9ARmAgggLfTSsGqYs0jA4TvwNxg==
X-Received: by 2002:a05:6000:40ca:b0:3f1:2671:6d9e with SMTP id ffacd0b85a97d-42666ac61a1mr2539280f8f.1.1759943976607;
        Wed, 08 Oct 2025 10:19:36 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bc01:231a:9f96:9bda:3734:ea43? ([2804:7f0:bc01:231a:9f96:9bda:3734:ea43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cc8bsm2913235ad.38.2025.10.08.10.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 10:19:36 -0700 (PDT)
Message-ID: <5bd37df6-1743-4b9c-a83a-a811e221489b@suse.com>
Date: Wed, 8 Oct 2025 14:17:24 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smb: client: Move an error code assignment in
 smb3_init_transform_rq()
To: Markus Elfring <Markus.Elfring@web.de>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, Bharath SM <bharathsm@microsoft.com>,
 Paulo Alcantara <pc@manguebit.org>, Pavel Shilovsky <pshilov@microsoft.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Steve French <sfrench@samba.org>,
 Tom Talpey <tom@talpey.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <02627021-da2f-41f8-9ea7-fd2da96e0503@web.de>
Content-Language: en-US
From: Henrique Carvalho <henrique.carvalho@suse.com>
In-Reply-To: <02627021-da2f-41f8-9ea7-fd2da96e0503@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Markus,

On 10/8/25 2:04 PM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 8 Oct 2025 18:48:28 +0200
> 
> Convert an initialisation for the variable “rc” into an error code
> assignment at the end of this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/smb/client/smb2ops.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 7c3e96260fd4..2513270ac596 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -4596,7 +4596,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
>  {
>  	struct smb2_transform_hdr *tr_hdr = new_rq[0].rq_iov[0].iov_base;
>  	unsigned int orig_len = 0;
> -	int rc = -ENOMEM;
> +	int rc;
>  
>  	for (int i = 1; i < num_rqst; i++) {
>  		struct smb_rqst *old = &old_rq[i - 1];
> @@ -4611,7 +4611,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
>  		if (size > 0) {
>  			buffer = cifs_alloc_folioq_buffer(size);
>  			if (!buffer)
> -				goto err_free;
> +				goto e_nomem;
>  
>  			new->rq_buffer = buffer;
>  			iov_iter_folio_queue(&new->rq_iter, ITER_SOURCE,
> @@ -4634,6 +4634,8 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
>  
>  	return rc;
>  
> +e_nomem:
> +	rc = -ENOMEM;
>  err_free:
>  	smb3_free_compound_rqst(num_rqst - 1, &new_rq[1]);
>  	return rc;

I don't think this change improves readability.

I understand that making the assignment explicit is good, but why not
simply set rc to -ENOMEM if !buffer and then goto err_free?

Also, I think its a bit confusing having inconsistent naming styles `e_`
`err_`...

-- 
Henrique
SUSE Labs

