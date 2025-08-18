Return-Path: <linux-kernel+bounces-773346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03DEB29E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFE816D5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E03101B2;
	Mon, 18 Aug 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysd5xhYD"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC33101A1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511192; cv=none; b=AuxHjY8CMHxjz9hYM8mM430pTLKUZfKlQ6ZrrFriX/7GTsoI/mfC+GAvUY3Svg+IPfMi8XnMWwTSV+PVvdRQ2SjujqYeDtKpXzt6O+MisnIFQ6nXusMqe6S9cZbRU2bwW69OeqfEQAfvJcztdLXcUbm5xlf29p+6ih3TEnittFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511192; c=relaxed/simple;
	bh=uXo2HfKIzXZcEAqe1+Cgkmi5au4JHjAcMP56tR1hXWk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u4oq+cLQAkijDevVvY/YVkXkFLz2DbltHjjlHdFuUrLIWNBhCDJIpZkrdi6btquhwwEw3HNibQwYPSUd6JD0bxQ80Ra0JUwLqJ+TzubaOkVMpXHUNCXwuBsyOYzKImGBezy+coD1OcGn4DZePtvy6BL8AyVJgAk7g3naWtUVpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ysd5xhYD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso31463365e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755511189; x=1756115989; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PAzYeYzFTOC96kJwyQ7IcW6iscdjbjDH2bcXfWJ1JYU=;
        b=ysd5xhYDGXECGnAT/n2KyxCW/wbIFMGMBZy94OODzaLfyZxJmFXkzETADId29xJTa3
         8TDcOFD6hTtRX6xc8l2liTlwmU+YCBh6Y9bcUq1BjRwJiW9HixocDe+C6p3xyDPYCM4i
         g+R7QoiUaICNqfCPAUgnbkqV8R8UWWmdnRSnI/mhwflRIFFLZjfYPWVzJuuYABadpsC6
         Re2ARFBEkoqRL3b9cwKUv0Bfm0kojG30PtEciz49yHJdzgKpvb7nEt4XFKHJl7abo44w
         7olO/9qNdg+YINzyN8S5yTCDlk3WsXkmvcsmKkWoXKWivH3+CF2AiSqKINbk49jPqqsI
         lLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755511189; x=1756115989;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAzYeYzFTOC96kJwyQ7IcW6iscdjbjDH2bcXfWJ1JYU=;
        b=Aw378nGpsnJh4tALRsdBlz3fP7Y8avkHy/ggW1SA4iRad4jIvEMV8Gv8J9xvM4FL0h
         /cJYZt1PCkAOUvCePhKZYpuusrYFcSzzDF/VMGm4sGe2wQnbOjHS6JZCzawlvD89Ir/z
         bjFeXM+o1VwAkUTfHInrvxxMUi/uR200h12dXIbn4VB7ROCR7+Kd620JHfcyBogkAkrD
         iFbHskOLlsroyoZiBYkjmFd8N1qXbpIxw45pfttq/hH51fbDZ3Py2OfUSJBCmXrokEAw
         S+/C0I9eE/MTgQ+qOT50h1rXblqIb1GGxt1md0FC0+FH0NLDyHF3ejrRrvXs9guMOfRk
         JkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo01GMYhTZZra8lltwG/gGFC7IK7Ezg+skvT9Tb3XYXlADbAoNaJDhxuNpsoZfXaPR95zsQ1yJSrb5gFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxMHt8jxmKdxGAcd8tqnqejvY8KEhXuvp+C6HeiOD8ZdtpMAv
	mJOwuAJgKs2dfRLIw56mJikMTr9UHN2qNRAFWlk3KFbc1mgYPw8V2yI589vyI4AGHTg=
X-Gm-Gg: ASbGncv/kXDurXoulXGJtsuQZ/2VO7xz+9Rz9WqAdrXDJYaPlOGmchpr3G5XikuqhTp
	Ic6lL0LZnof7Wql96unRF9JorFmuErBKyOLkFW5zBOH4VfaJQTHOlSuznhN89sXynt0Sbsygab+
	kiaUJWKHkYTQsfI6J4Z3S4MPkopfVIUiHpuLmoB9j95mTA2Dv85qFh/V6KurYuz7jSZCs00IiK7
	DVqZPJHbPlRcbCphJQZBhIq7shungQz3zFFpK1FVHNtj4GSrt+2h/tZFzhzs6qWuYyhBc0W8BKb
	xOS7FqAO3QiDsYILn2244DJpIOpgF1KJPDfSEpQ7MTrW99yocIwxBIIP4xarKUD6TdjQu0UZFi7
	v+hZUFxXHwOW28NNFMK527vSymT1906Hms5j8LHYYaBs=
X-Google-Smtp-Source: AGHT+IESeM6A+8YV4kbdeq3Rgqzb28xUjkrQolArR+kWnKAsQ9pql4kCFEogW9+cFxcDvalPpojZnQ==
X-Received: by 2002:a05:600c:444b:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45a2748c3a4mr49153035e9.7.1755511189272;
        Mon, 18 Aug 2025 02:59:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c78b410sm172408255e9.24.2025.08.18.02.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:59:49 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:59:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Karol Kosik <k.kosik@outlook.com>,
	Youngjun Lee <yjjuny.lee@samsung.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Fix size validation in convert_chmap_v3()
Message-ID: <aKL5kftC1qGt6lpv@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "p" pointer is void so sizeof(*p) is 1.  The intent was to check
sizeof(*cs_desc), which is 3, instead.

Fixes: ecfd41166b72 ("ALSA: usb-audio: Validate UAC3 cluster segment descriptors")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/usb/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index acf3dc2d79e0..5c235a5ba7e1 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -349,7 +349,7 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
 		u16 cs_len;
 		u8 cs_type;
 
-		if (len < sizeof(*p))
+		if (len < sizeof(*cs_desc))
 			break;
 		cs_len = le16_to_cpu(cs_desc->wLength);
 		if (len < cs_len)
-- 
2.47.2


