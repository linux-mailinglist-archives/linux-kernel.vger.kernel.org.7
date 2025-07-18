Return-Path: <linux-kernel+bounces-737365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62109B0AB61
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C828AA38C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AF221D5B0;
	Fri, 18 Jul 2025 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JsofT7/6"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464321CC5B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873855; cv=none; b=czlQua4V3sV5kiS1qxzZuQpVrfPIQT9UfLn8tUGKEJDwChH3sNIJ4fiiw60K6vpLfvPZAWzEYuP0gRpOxMF80+5x/hkLFJoEDhcc7fABPZNh6LZNhDXsAKirek5CRnAGxKG+SGcdXFF0THzAKtuddrpX7NBMHi8UbJ4fOsFnMDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873855; c=relaxed/simple;
	bh=oIUJkdIPsltITYmnYkXF0c8cUazSTGDIqJj+KFFWPfk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IHLx+sIuo+OWTZrXx5CEyCGnfFPRzR4d2ritjY/nlvRJY8iLqfrCwvuBIEywKidQozXYGoTcoQ3gDc6KBlcsweO3qXvDuUgR9qnYtLmwsipgDX9rhSqxfb8PsRTbrgLjOPZJ1hQNijOkTxlRf4d0W1otsgxXQNH8ZLdDz16NUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JsofT7/6; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-615913ff67fso1618057eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752873853; x=1753478653; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNxBOflrGholZZGn6ETa6dtvAbfBYl8YJ2Uz1dv0uO8=;
        b=JsofT7/6KmbnknXZmksJZxR0tfEYEhXIMjBMh4XWRHWW/3/0xcUVWPd4RjE2xy6Dq+
         mA0a8Zj+lhSxJ55v5Y/aUeM9yaqyWtfsArK7Ua6o+FVRJYdDTOwcYJJTrA/Teo9iS82B
         +R7b/F+KX4A4GiwfuuRhSBh5LXHC3ydwWMDgQ0S+x+K2udE61Co2QaDCFSt7v0L86Rt5
         bExkDrlBeibSfd+9EwxQaiDdA0j0xu87weETvMwUg5CunjBgXzJIm2G6/+JLbuvdJxMe
         TVNnSVWWIorLCjbrGmx0SuQel0elildilkRJcCLDRd8yDXRGOF4ETEBzk4YU3NTL7Cpg
         Bv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873853; x=1753478653;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNxBOflrGholZZGn6ETa6dtvAbfBYl8YJ2Uz1dv0uO8=;
        b=Wtucg7wnxyuYzVpCnxNtJD4wlbEzOH1fAHM+TkjrF/evLiq+0PRwgx7k5QgzNQLyUR
         iuymbGq7hMZZF97CMi3aNlnANqeZIqAfULQDlVcvw+6+XF/xm0upr4em89rovTq8pzur
         pxjYujigub+QV93dvzZM+BbnJNA9KPGI58+Gu1EEomVHGZNbTrVnkhbWPrPgwlpgkqal
         iN+/a+Tewxw14eLtWMbOpMMm6lLJ5WmbeQuyVgBoAMNdFzOS8epRAleh6i0AU/vLTicM
         X/E6GkdCeMKUKcv4zmluwsGlTOHIN/0pxDoOoaE81u5jkJEn3Ym2p4lDrWFaNp9TnMVu
         pfnw==
X-Forwarded-Encrypted: i=1; AJvYcCUZbJnWcfg7+cfXXlvDB1nLsv+q7fmxufSfSDA2II4Ha5df6wte5UEQ8/4c5moPuVYZy58ZMEKaMhisULo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/a5TN1dlYrRsBrZNhkNKE5+lc9b3ho/78vrmVdibQOXTw3K7d
	WXvXaOZjrRORyvvvv191Un0IZAG6hnpVoEBpD0lrLCU386dl+As2hshhGE7H1BX8P+U=
X-Gm-Gg: ASbGncs+uon0B/0DPtCRf/jB6yVyud1aX+hygrpNB1Tg3JRwAg5qlKhGlmiaQasHzHf
	fAQn5sqP82v+yAc8Gmnexsg42XDtH8qOPN8yH7INei3pncAQkDINZRT/i3V/a1dt+WeoVSRCH7k
	Jsdl09yuGzSIWALJpPGzbgYpWQS9Q4LNiEWtHLVZGSUCaItTCjz589L6/3ZrSi069UfbU2kWVbe
	ZB00sYOnx+gVFr1uhbh8pNXuxX7mZ5VLw5iSQqEk/mQpuIKufqTer6cZ9HC9FCfZS0rvUvoLgJF
	Iy2BPmadeJL9N5Eyb8D3+X7+bCw9htwY/cfZLTQXRdQL3mZTXGMt5OfKkuKwZxm6iaiGTaF6IZk
	VHgCVl5cZJLA=
X-Google-Smtp-Source: AGHT+IEL3dk12rWlHef82D3RUYaodYoVvVhdwT5IY/zd+GI8cwXb6B+5Pe8H3kNTEx7MGpyhUioiyg==
X-Received: by 2002:a05:6820:2e84:b0:611:5a9e:51c4 with SMTP id 006d021491bc7-615b81d8a6emr2878681eaf.4.1752873852935;
        Fri, 18 Jul 2025 14:24:12 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-615bcda4dc6sm519931eaf.27.2025.07.18.14.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:24:12 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:24:11 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Cc: Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] fs/orangefs: Use scnprintf() instead of snprintf()
Message-ID: <7c4eef67-7bbc-4a4d-ba10-ccf30c6afcdb@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We recently changed this code from using sprintf() to using snprintf()
as a kernel hardening measure.  However, that's still not ideal.  The
snprintf() function returns the number of bytes which *would* have been
copied if we had enough space while the snprintf() function returns the
number of bytes which are *actually* copied.

So if there were an overflow, the conversion to snprintf() would prevent
memory corruption but it would still leave an information leak where we
would read beyond the end of "buf".  Use scnprintf() to fix both the
write overflow and the read overflow.

Fixes: fc08e0b8f099 ("fs/orangefs: use snprintf() instead of sprintf()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/orangefs/orangefs-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index a5fad515815e..e463d3c73533 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -396,7 +396,7 @@ static ssize_t orangefs_debug_read(struct file *file,
 		goto out;
 
 	mutex_lock(&orangefs_debug_lock);
-	sprintf_ret = snprintf(buf, ORANGEFS_MAX_DEBUG_STRING_LEN, "%s", (char *)file->private_data);
+	sprintf_ret = scnprintf(buf, ORANGEFS_MAX_DEBUG_STRING_LEN, "%s", (char *)file->private_data);
 	mutex_unlock(&orangefs_debug_lock);
 
 	read_ret = simple_read_from_buffer(ubuf, count, ppos, buf, sprintf_ret);
-- 
2.47.2


