Return-Path: <linux-kernel+bounces-759585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF4CB1DFB5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A751AA3977
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030B26A0BD;
	Thu,  7 Aug 2025 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="ciWcd/NO"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69D230D08
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754608018; cv=none; b=rvy9oHxwcnuGBREbu2PPcUHmzGQil+5KQyK2WeGFe4V2o3QuWNpxs8EBndYczCwmZ71lzRvdUEnebypZmfP1nBiXaxO0HDh2R0li14M1ahm+mIw7IEiIEp0FIrE5sfAAJW5iHLFn5frnV9Cxxv6al5Z362AOkHw2aU8nnD6L0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754608018; c=relaxed/simple;
	bh=XnzzWeFclycoyV3WVLzY89GHQh4oC3YJkexU5+8rQdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTmvqHosZkUeg1aG/PxE/p1qGXTTyd8FCWLLNGnyird1aqv7zPiByidN7vJmTPvqd5R+D8CP3sNW11UGhzvPB+vaqK85nWqVHxvDApc80SquHEtE8b2koDoN2vuESlMYNz6jw5yepKOcvg9Sh90i61bfuhP4fz39n4BCc0BA91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=ciWcd/NO; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-742f983e313so1270140a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754608016; x=1755212816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVQQCNkJrwdiyjASsKZtUkOBNZNo3VxgfrQtjAg6B8o=;
        b=ciWcd/NOw6cSvn4BzY/+qY4OyopUI2crKcuu9nlrHa+689ogriuvSOf0EfdqK29yI0
         juNCsiU8vdz01S8yfxY4Box/wLwUw2EpsSo3BLvtL9Ys9hzAKfNz6WT+WXFRKwXz2UPK
         5KcW2oU3u5bdkoqKqd8nTEH9WqxOlMbub1sejJ/vhjDxEdu9CbeIjN1dgY3UTlmaGwiz
         6TAIljh12Ul5N61HOy6DrjYdcfQHSuEFzWkvSN7OJt3fsXMqnfYR3dbVQS9rVJvyKXra
         i4ghhzJ28IpPXWPphtgslejlD6YOG8xP/voJ1Pth3OjpJmhgG46266eoKll8qzo1neAV
         tjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754608016; x=1755212816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVQQCNkJrwdiyjASsKZtUkOBNZNo3VxgfrQtjAg6B8o=;
        b=Dlz2FCGg/MSFCd5S4VvAd3DEKSjMVQjg+SQktPO05Q0OZfeZ2aP4d7Pfg6PUiEPNNK
         qe/I6lVzgE7Ztek1HeAxyx2DOmSTqxRjdKCYbOQok/WqgwzwShd9en9OkE0FtFelm9gx
         iBvOVByvaV97cEF0KK7P3zsL9dRIZAiHZhxYsFOfUCHyPAOvuYEFoerO4FR67uxPuhvr
         uolKvdcNC5NMjeiobEPIQ02f5DwqJl8CMna/Hm3vJGk/kR5SRwhmiDBNbfGoFIRiHvzh
         qfvNt0D+X8OHLzTCxQe9V+AyGNcHwDPOiiIXitJNMZX/6F+SYFZTqfMHfY++9eBAqSHj
         iJ0g==
X-Forwarded-Encrypted: i=1; AJvYcCUBahZ8zFRgMqhfFPJo6jXNWTBsw7lMIK/+4T6nbWR1n9Gj2sDrrIeU4+86dQY12TLNy1W7sZ+XBRT2gsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXFWfu3jjTi3fj2ZQXo72S+yneMGVQC13P9f0HGR9BSwtS6c64
	YGps+UA2v8z5yCTDKK73S2JfRiVlXltBqKL6ZfEDwxUeMCBb19qWB5DeUfKNdRTKpM0=
X-Gm-Gg: ASbGncsoACOl0YrxvDzbLyZFCtyRIs6PoYClqxOxC1fBsBAsr1JIE8CNkLj19Ch7KZW
	0Oo4wDaNv/uV+Rq47YYJf0UawF1BgIHxpgY+vvV271IOXibMW3FBjI9UPFybM3Ef6+ekU2MHu5U
	VeSOf7+pP7JVRjOgEHItdODSz5KCWfVIBc5sTR1WYh8lMJjiBDqaFpcXIKHBuZAWd/w/zH9MfIS
	2MaAOu1b52EA1tH8KX+SlDe21/wPzm0huxfJ0AQaqd375SU7be7za8wI5R01qxwTaa/4BSFp5pp
	3bdMOCqC6EiP0XQ9brV0QrhRvQmiOvs4XD2oxMY1CIvkfwHw+Iijz2cFX1qgy4hS6Q12m+2aK+4
	X+GT6VihUivJjCwR1
X-Google-Smtp-Source: AGHT+IEuQZJXqTEndB22xbDSCJVb2dZ1VjZOrq9cs/j01hyqUAng/aQxtGnCN+AeoAudDB6/BBpFbA==
X-Received: by 2002:a05:6830:2b27:b0:73e:9ee1:3d7d with SMTP id 46e09a7af769-7432c9879a2mr685880a34.28.1754608016344;
        Thu, 07 Aug 2025 16:06:56 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:e698:accb:897b:ca29])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-742f57d5d05sm2099930a34.31.2025.08.07.16.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 16:06:55 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Frederick Lawler <fred@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 2/4] ipmi: Disable sysfs access and requests in maintenance mode
Date: Thu,  7 Aug 2025 18:02:33 -0500
Message-ID: <20250807230648.1112569-3-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807230648.1112569-1-corey@minyard.net>
References: <20250807230648.1112569-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the driver goes into any maintenance mode, disable sysfs access until
it is done.

If the driver goes into reset maintenance mode, disable all messages
until it is done.

Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_msghandler.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index f124c0b33db8..72f5f4a0c056 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2338,6 +2338,11 @@ static int i_ipmi_request(struct ipmi_user     *user,
 
 	if (!run_to_completion)
 		mutex_lock(&intf->users_mutex);
+	if (intf->maintenance_mode_state == IPMI_MAINTENANCE_MODE_STATE_RESET) {
+		/* No messages while the BMC is in reset. */
+		rv = -EBUSY;
+		goto out_err;
+	}
 	if (intf->in_shutdown) {
 		rv = -ENODEV;
 		goto out_err;
@@ -2639,6 +2644,12 @@ static int __bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
 	    (bmc->dyn_id_set && time_is_after_jiffies(bmc->dyn_id_expiry)))
 		goto out_noprocessing;
 
+	/* Don't allow sysfs access when in maintenance mode. */
+	if (intf->maintenance_mode_state) {
+		rv = -EBUSY;
+		goto out_noprocessing;
+	}
+
 	prev_guid_set = bmc->dyn_guid_set;
 	__get_guid(intf);
 
-- 
2.43.0


