Return-Path: <linux-kernel+bounces-886643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC44AC36271
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF0A04F8150
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB9231AF39;
	Wed,  5 Nov 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpJ60Q0R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pd0rCp4Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8F246BB2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354103; cv=none; b=j1ixQowmsS0jI4TSCZ6oUTfpatZz0bT4g7OQRUgjE/mnZdbx/GVeel0cNckPM9MAdDqesR5y2YkadiTbRAwQLaX3X17+ekbPkRPaLteHeJ49mr1VihRrkvxyJrRj8x8vKA1PH8lwWN4OSfcgwCwOy4bpc6fa7mexHV4i5hJxcSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354103; c=relaxed/simple;
	bh=vSOblu1TYmytU32Afj1JpSAwMW78+1eufiWSTZpAYPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcFCyktuzkf4xs4LyNRxkdJa2CjAUKUDZaQnfuOeq6GA+Vp1nL1DCLLn56Oe78yNjf+4XhyY3jpU8Yvqli29LQBEHkVG7fV0bb0tu4Lq2J1pufjYNW8X0iTG14JnHESN2gmRR38VXo6DL4YRF14qmzILNhHUgIpUu5svO92izmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpJ60Q0R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pd0rCp4Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762354100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CALwuHsQmFBRZ9UMoQkNa65lCmf3uyfowmB88gX3QjM=;
	b=FpJ60Q0RIPNVXpxnt7RX/LCqlLLf5JH1gXZHjEAtscw5qKxrDTjPzOJFaRhkuIfUDxmslp
	GbmI2Zl1S3qnbSEyy+UyQF8YyDqudXOP6atBPJwD52HMwZULQ/TTmGx6jZ1RL18hHicth0
	V2ppGWmUD7sSbNk9DD+DtGB/8DWdJUU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-S5NaxXQKNdmyxWGZg_cQkw-1; Wed, 05 Nov 2025 09:48:18 -0500
X-MC-Unique: S5NaxXQKNdmyxWGZg_cQkw-1
X-Mimecast-MFC-AGG-ID: S5NaxXQKNdmyxWGZg_cQkw_1762354097
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso729031f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762354097; x=1762958897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CALwuHsQmFBRZ9UMoQkNa65lCmf3uyfowmB88gX3QjM=;
        b=pd0rCp4ZLTM0rGr4rEfF6Vmdxl7W6SGK7ejZTrCZTTlkXY8rCPpcZED/9bYkKE7zcr
         wQJafIJ+zqzbAsJMim2qpgadGsrXyIfweQO7BLdoFJGhH7oUHMLaGQghhL0Bz/vY8f6b
         RhQ+XUCBpHdyBmbqFgTB9dSTzi4JWCK0f6srMgkxGeMyePIN1ooxAXJf/Ag30fqHNf4P
         DmbN/miHhaJZJsFNPU386tiOIP/MqlUl2o1UizKaq8zlnL9kJS7vPJHdqu2dSE0pFVIs
         V7oqQYDCTiUmueWpbemLFwoviIyZOJCiLpNDAcwWmDd5eDreeVG0aRznLKi3KulZMKC5
         x0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354097; x=1762958897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CALwuHsQmFBRZ9UMoQkNa65lCmf3uyfowmB88gX3QjM=;
        b=RXNUnPRCU1nN3UUrcz3QwyjCK5Oic2GS3YwwUsrXNSFZa9IIhekdKDuNN5qzlXakzT
         ENAdjxecO8FlB9cuzmEaaXoETFjMEeCmBRWv5NC/p7nECUnW24ayp/1fkQqi/+L4nffC
         yyhqTMjiUmxHYs2+qOVKbSGE4UPSgNZhiXqbwJ0gxLhzvXIlRSiV+gI43IduO7zHeFIj
         KkTmIYMp/nK9ht6imu/1WLbEKFqotuGFAj8b/s4V3+z7ERPTwV8g5bl0wB2XwNHnTfLS
         QdI0ZmZOwvOrgvjz3LPvwemvRlF2UL7ltMaaIgocPoLlVPsVnVC173EeMXSEBqkvPioA
         RcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmO6Eo0kJfsxTNjk4a1ZQ60mVpokgzRAfbKYjb2f2K4WtpY2MgLHEKzJPRf4WxbJbnrDMuagyBOAYm+yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmmyb8pA/YpX8WIHvKhPXU0MBL0GkX3V11mz/wboTYu0gvuWOn
	M1oHoNAU3PKB3Vs77PAm4U0KJN5eOAsI5GDymRcy7hZHCzP+sbJkrDRS9YUf+9xATVvTiA4Ju8H
	7/5AdaQ3ZCPhpYDR8er1/ZRqCaakyd9QzA42X7d7PQnQLUQzb3uKuDfXWZElEm2dNRA==
X-Gm-Gg: ASbGncs7mtS8ai/2FLIBidQ6f6eGLDpD7JtRzkLLvPn4Orldepv14U5nzb8FdLByP+R
	GoPlONwLMs28pOPXogzBc6/Uh8clTUW43O2rpXYjSTiB64XmLuCya89MEZ3til55WwzbOzTHyhr
	i5i4uQs4X4r4InxD6ETK7pYS7JqkBw+1agzc23C8NbnvB356eCO5mIdj+vKP1wbOOxqF01Tk0FF
	cUnAs2UkHe6jztzN2K40ocPJRKhd9vDWt7ps4rrl+/odXY7Fv+B+yDBjfG15EYt9dUYMdxUnpjM
	/vW54ouEljBAoSNX+mdZTAaWqBmG+DmqHSb/DrKBTHdHy+pssc9ZYOQaJSlRgMVXVd+fLVoLCOc
	=
X-Received: by 2002:a05:6000:184e:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-429e2d91fe1mr3951415f8f.12.1762354096645;
        Wed, 05 Nov 2025 06:48:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrOCNYKDLHdDqnsKK5PIOXbPko9O2ocFPx7Xxpk9jaY5/59QMJwT5e74pWkY0THQmdo2gCiQ==
X-Received: by 2002:a05:6000:184e:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-429e2d91fe1mr3951385f8f.12.1762354096174;
        Wed, 05 Nov 2025 06:48:16 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efb3sm12092871f8f.3.2025.11.05.06.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:48:14 -0800 (PST)
Date: Wed, 5 Nov 2025 15:48:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Message-ID: <csgl7tb7jxlmbkn5jqjoiraa4a5vatmd3t4fv4duue5ftukphy@tem4fwdinmti>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:39:00PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Testing with 1.37 shows all tests passing but emits the warning:
>
>warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
>	The following versions have been tested: 1.33 1.36
>
>This patch adds 1.37 to the virtme-ng versions to get rid of the above
>warning.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

I'm just worried that the list will explode. Perhaps in the future we 
should just define the minimum version that we are sure we can support 
and the maximum that we have tested.

Stefano

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 3ba9a0dfdd01..0657973b5067 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -152,7 +152,7 @@ check_vng() {
> 	local version
> 	local ok
>
>-	tested_versions=("1.33" "1.36")
>+	tested_versions=("1.33" "1.36" "1.37")
> 	version="$(vng --version)"
>
> 	ok=0
>
>-- 
>2.47.3
>


