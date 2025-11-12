Return-Path: <linux-kernel+bounces-897105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7892FC51FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231DE188C385
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394C330DD05;
	Wed, 12 Nov 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZwaMj6D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwiNzKk/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F230DD04
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946861; cv=none; b=IgcffLLWA9zu1K8pfBiuL/qm9Rh6PgtMgl8srqhICgy8kJiK2lJbNv4YmUqXdhcQg+2d7KIociPGuWQwQhF1YBU4zU/fjffFktyYgMikT9QeZc6k2Hy5hqrrUsxWS7K9iXJFUPWFo1S2RKwdHBw8v+qMf7mw9Juj63zSlaReN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946861; c=relaxed/simple;
	bh=xRBVszb46PCRdqH1h26lnmIbsU3o+gPYt33KkTm/MtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsH6Laa30FqfIGnyIERRRmwWmg+UyA3elcv+89LHxjboQLYOUjb7xRfjkaNrfWCLsdPyjxrRG4TYHmq20sLUDSmTfgQjW+MZ5iNsX2eCFOo18jlkno5obfy9HmhrqUxiyG3ORvkfrbn3Wb8ocCmXXn8wL3dORJ0lQjZr19foCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZwaMj6D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwiNzKk/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bh9ROHXwX8NyJE0uRznqL1+0stTxgI+FrZIpPuJINh4=;
	b=LZwaMj6Dtq6ABCD1HANIDVlWHgNSdd7fmGkp6h7TJH3Fagx5eJ8J4IVeRroWSlyG8UkHh4
	HMkjaxzZful+afyPob9gHfYZDuSgaSZuBXKN1w1sFxTrWd8TOqBifZWGQUtE15IebE7Kgp
	sHo20dDfPMWXoSqWOa5MbW9JE3E38dc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-RYaWOWqDNO6v5ugsu6PP0w-1; Wed, 12 Nov 2025 06:27:37 -0500
X-MC-Unique: RYaWOWqDNO6v5ugsu6PP0w-1
X-Mimecast-MFC-AGG-ID: RYaWOWqDNO6v5ugsu6PP0w_1762946857
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b19a112b75so182607985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946857; x=1763551657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bh9ROHXwX8NyJE0uRznqL1+0stTxgI+FrZIpPuJINh4=;
        b=HwiNzKk/ipkanZInrPGA4dGIyMGH9MMLsIGqg81shKdAxMIWQn28to8u0YbdwtN5Kq
         Ij1XFwQnrkcj28euGmHyUSPCZpAgxOtgTaUGotJbdzaPT+vfK5ZPC4oFO8s3exTKZcMd
         7oyBNKwj3Mq0EV00hu/1e5YQ+12gFvjApRbCMkyeXHy1pkJhluZoMqu99TGq6PDd3bCb
         QvRFSP/GJYrkM5WU2f/irGr4sBfTMzy99rGCE0YYv7dFIl4wCEdEwxfLXXpvxkzgZMiG
         Ed06dtr3YBjR2oIkPKxBJyI/9C7P3JEUiMLfAWIYqI2FnummH3En8y5TLSlgHbBbi+GN
         WxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946857; x=1763551657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bh9ROHXwX8NyJE0uRznqL1+0stTxgI+FrZIpPuJINh4=;
        b=PbJe+LItKxDEfJSoPggX9l28PuQkSkXUVKd/72pfHH+pG0iJNExiFTem7Tvp90TRsp
         +qFsR1zvBRaVAUO2mvsi/ademHm2vatdBPX4aNcsmaKWcL5yswVZcL1cEcz/L9bCcIo5
         M4mTLezPUkbuDNJ6L/An3GSz1zuCMD9H/nbDUIIqOF2yQAm5hIMxNBjPd+hV5OJ+VLm5
         6SGNeRfskfIwFg0J4ldP/f+Hg7UinzHHLxefaiiowWzYa9AT/S3TkPC8TgmyVNpwDl2Z
         DNpE+ON5dV1QZZqrA/92c2q8bY8U5hoRUhIYPOIFUgrTa9nERP4OQNcp+BWSf4+yJb/m
         iGmA==
X-Forwarded-Encrypted: i=1; AJvYcCUTftSULm3DV7XWWxPaCFB0rM+rM5rXMSz1KYcSEOH+MefttHE00FYXyRQMhN9fRx/U3rVVgy1ABBIGDos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqt7zL0+O0SlVXopTtB5GqzSi2AeRoOvaoYXbhiWbj4TAz7066
	4kIsmzezdUddFzH3QAZXdboJ79EpxFZ4a1PuCxRWCKBpKIz8NG7UsVyKwhqcSoiqL+Je1NDQCh/
	U3A0k3izkOkKGk3W4Bcs08hJAiN6ScQBy6M6vQcPIDqo+hTYF3EXJK6qJMMYXyYXLaQ==
X-Gm-Gg: ASbGncvMAMKzZs137YIA1SO/OadTfaX23RAn7cl7hfl0r2AFMg54D1IrdOR5EsCQiDH
	iBgWD1PK0jxGuGTtNSbCvxnnTZ8vCsXp0fpZ45MSXzr/avxW0Sxw3+gi6VWx4Dk6suaiwhJeEU2
	EipN+Gcl/NZf4F0AJckWf/owXWRfIIViHTD0Pxs3AeQN3/56XUCBXsRQUqt/MPY4PIxREIDcp/e
	r46ivP/K7wWdeRYoUWTaLwfYmlstcdM2XqPkouvKTFZ0ryftkPEl4H9/0mu1csRxJ4TXwv+U7O+
	auUM0TxYd/qci110eTe/ykZxnt70FSgjWwzVUtaStpxHdKo1FWQs5fXg8cjhk0b+RdbY/yWti6I
	N8KtheaJyr0a8ZRa+gJM1jVGwnpwAUBvtEj+PF0nfLa19VK04SNA=
X-Received: by 2002:a05:620a:2911:b0:8a3:d644:6937 with SMTP id af79cd13be357-8b29b755312mr300897185a.6.1762946857230;
        Wed, 12 Nov 2025 03:27:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1QM6xpF4cwT0P5BoTaUqTULeYAONrpImDd2Wx6DOvB/yt3c13Mp66Q8AvPTabRL1NdGvMrw==
X-Received: by 2002:a05:620a:2911:b0:8a3:d644:6937 with SMTP id af79cd13be357-8b29b755312mr300895485a.6.1762946856845;
        Wed, 12 Nov 2025 03:27:36 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa00850sm172322185a.44.2025.11.12.03.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:27:36 -0800 (PST)
Date: Wed, 12 Nov 2025 12:27:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 09/12] selftests/vsock: add BUILD=0 definition
Message-ID: <ay3utqbmbi52pizmrp6zrcitxjftyghfkotjamgeicwlwv52sj@j6jfpj35rssm>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-9-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-9-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:01:00AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add the definition for BUILD and initialize it to zero. This avoids
>'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
>set to 1 and is later checked for its value.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v2:
>- remove fixes tag because it doesn't fix breakage of kselftest, and
>  just supports otherwise invoking with bash -u
>---
> tools/testing/selftests/vsock/vmtest.sh | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index a1c2969c44b6..e961b65b4c6e 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -548,6 +548,7 @@ run_shared_vm_test() {
> 	return "${rc}"
> }
>
>+BUILD=0
> QEMU="qemu-system-$(uname -m)"
>
> while getopts :hvsq:b o
>
>-- 
>2.47.3
>


