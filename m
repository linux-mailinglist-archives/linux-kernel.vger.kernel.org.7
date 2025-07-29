Return-Path: <linux-kernel+bounces-749090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD9CB149F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118617A1157
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F4B26B2AD;
	Tue, 29 Jul 2025 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I5J7BsrX"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DBD10F1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777113; cv=none; b=Aty3uQXaO8ijFd65DBo6eBhnhTsOuJnJQoEh5Ra0eAmqefbMMFItEDLkI9ToZG4bFvHLIzJTnzozs2kvObzmkPF5GTqlodfCK/AaX/TrHrqkTpJk30W3Uzds6gIovACpd9y3CAupcvxnVDAJJu1IKT8Xgp4+RmX3gbPFH4f0p78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777113; c=relaxed/simple;
	bh=zdCFipoAMqtFtzhuunls+b0JQOmqMK4bDMkbae+8qkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTinNHpoqCPn7PiNaTOeFJN+YdtUtAUWwkjSHxCC96Iq0OodcRN77AjXpcYjtZRmQRC99Dc3hiHOo+3NX98ZPortL7/DLBpk9W5WY9qsTT4lLObVWPY0a2KJ7wru78bmSWQBsiuqEgFC4uhZh+v1eG/I9AYNCErxKPZeIp/ntGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I5J7BsrX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7920354f9so199994f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753777110; x=1754381910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5tE7FPM7bCW4kbZB6U8nimZVyghXTUZICxGa9LrEk30=;
        b=I5J7BsrX1Z4I5+GqFv1hhadwIC81H0NJgT8YZjqKdWthYbEjsQAqKfj0PcW+VavIp9
         /EviNbtzvD4bRjnbPkETCJj0N/1lnA1JLxMr+4gQ4OSfswrEEVEfwzMvjkGjFpyR0leR
         Qad9w0PlXgZpQ/xweHE+RU/LcSjtHy/gLsPxT8WzQFUJ6rJVYO2qVZ+oQDnxQ3ixvqlA
         wwJKZxztihAq2/bnULaCAZY3gTdvtwO50r4TzhavbfHo3+WOPQh5TsKZk8RUh860u8mp
         6i/dAKtWh0h3tCDvDOrvbvwYnaD5pUTBitt8BeLyXz0ve4jIsTS4FLGn8cifFGJUjn9T
         4Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753777110; x=1754381910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tE7FPM7bCW4kbZB6U8nimZVyghXTUZICxGa9LrEk30=;
        b=gtQp2W5i0HDTTaeNtUPTUpZHS2dGlAxhnJc1nsjVY1z48kMJInRfLFO3AbaA7mkQUL
         hgMH7OIEA4Sbz7cLT7TozDZgJwT6UhmfREL9NIR4+GudxMGatBVzZJfPra8GayGbJOKe
         FFvlk4uijJQhkToojHuXxJBtuTyjk6h2u427UPX3hm4AnM5PxyIvL/NYV8fR9t/uvTnc
         I82nHymGVCU1hcLLUQzrPrxh9IQvgrK5gjuv3UJiszbsDUhZyZwXJZIso2wQa8p2PqYr
         xWmmILuBdG1ajKFB2IvkK+tGFM7hJwCNZv5oCPrMhFfQmikjkg2K56YcUDnoeDLjTob3
         c2bg==
X-Gm-Message-State: AOJu0Yzul8B+MEt9Ux9Gk1uoQPH1MG+jjUcsv7hgFZW0lhInirB5LJ9m
	RTeNt3TYIAs/lIEMYcyTCUgONm/FF8Xr0kdHWoWK3ONyhYf4cDYsxxQuilKxnfCy1pA=
X-Gm-Gg: ASbGncs8guVCRBap8HEagaKK4mwZb3O4cz1/10ExLzWXdeZWj2jbqKu9NILTO7hbNDu
	qCquiENa1S5ChGuDLDNiggLpKxDoUry6NYwpCFkfWTxQusiuwuAWjfCMdBpSvdRaxGg05eeAdR+
	pSDzG4QcwFI3FnOi4UIstRxzveX4s3Jg4ErQKkQqDzpGmCohDE/0BeugErouA/nFkbLqGZqg3xL
	k+O3UQ8EOekH1njpVIsAEP6OvejKoKiFrPFmocCjqf8CSSJUZJEQqBjIZy9uvDisOTJnM+s77Bs
	qsbddSHgYX/ql/AOm+ejR2u4HC5sewu6eHD3tzwHtLXVj3pyngsT/M1xiBHAE3wzxusaaijAdei
	VBJggPfBMaxnVSh0rH+x0fg==
X-Google-Smtp-Source: AGHT+IHWgetaJ+bLITTfnbbpw97+1qRhZQny9XgDlKEeA0tbNdvgiJrjWETo5ekLftie1aP8rTSS0g==
X-Received: by 2002:a05:6000:1881:b0:3b7:806e:7773 with SMTP id ffacd0b85a97d-3b7806e7be9mr6523326f8f.15.1753777109815;
        Tue, 29 Jul 2025 01:18:29 -0700 (PDT)
Received: from localhost ([2401:e180:88a2:4c10:c47b:26d3:8f9b:63])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31f327ca4f4sm989256a91.0.2025.07.29.01.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 01:18:29 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	cve@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	=?UTF-8?q?Jo=C3=A3o=20P=C3=B3voas?= <joao.povoas@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH vulns 1/3] add a .vulnerable id for CVE-2024-53099
Date: Tue, 29 Jul 2025 16:18:22 +0800
Message-ID: <20250729081824.85105-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue is present since the inroduction of BPF link abstraction with
commit 70ed506c3bbc "bpf: Introduce pinnable bpf_link abstraction".

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 cve/published/2024/CVE-2024-53099.vulnerable | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 cve/published/2024/CVE-2024-53099.vulnerable

diff --git a/cve/published/2024/CVE-2024-53099.vulnerable b/cve/published/2024/CVE-2024-53099.vulnerable
new file mode 100644
index 000000000..3a7ce7976
--- /dev/null
+++ b/cve/published/2024/CVE-2024-53099.vulnerable
@@ -0,0 +1 @@
+70ed506c3bbcfa846d4636b23051ca79fa4781f7
-- 
2.50.1


