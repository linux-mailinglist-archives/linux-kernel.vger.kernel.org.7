Return-Path: <linux-kernel+bounces-788960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A7B38E92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5254A1C2203E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E137F30F92D;
	Wed, 27 Aug 2025 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL6dW/qd"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27EF30CD80;
	Wed, 27 Aug 2025 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334573; cv=none; b=qCCGYmZz1GBD224sGdCA/+r43458qzbHSbApP+rApixkOiy2v4AREbuVKaPYugLRayhXqpgDWshIpqH7rmpIkDTOzu1Xg9B7PgcHC+UaN0FttS6J9kJljPPrKBt2i/DkAjXjW7AF3w5+JZXnZmj/lDfxIm0nlQzHVCKqCGDZlvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334573; c=relaxed/simple;
	bh=OMCNLZOTWG6XfuKaKvFt/YwKhh5uV/0qN9XEsfTOj2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB5e9EXeZuRJDB8LhI+ALhBDOXkC1oOQQ1ZcuN+zHuh11L7JzQPixKzbVb9AVpxYe3160DQNG7w3U3QauUaDWw7gL5rMilOoR4XVz1X/pnt4bH/6iIMi7JLPfIK9shXZB+rSm3Gd9dR2Rw3VwXgGWzSySTwPrLHaXxMsRQKuBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL6dW/qd; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e96fbf400c0so460684276.0;
        Wed, 27 Aug 2025 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756334570; x=1756939370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0yzbcHFcSfCY3poqfoWp6u7+jrAbwU2bPd9RYtjzMc=;
        b=FL6dW/qdOesmNshW1VxzAvshXmAfMetFdpFC9MNjiuZ89l8ULe+sS1peUg/+KoZmeZ
         7iad6bzX2+ofySDPMelYjVBVL1V2ZGGfMZuFpzaPP/14Sn9nKC5XWrasch3/S32hIAw5
         03sBGXwBp1n/0x07w/8ptyfTOPavIlzr89A1foVe/95SZ9u0Lk36SLXGj+Aq33D3WPjk
         PdKvAhhStnlzJRm0s/KEK925e4PttDOK2GCKftVYrnnBMH4mhzkx62lrrXtQDwCR7Xpn
         zGG23fTxCY1nbMw3Pm5t29THH7L9vNHrhF0njh1eL9pekIESVEeEl3aIY+icalU9WBWt
         +0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756334570; x=1756939370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0yzbcHFcSfCY3poqfoWp6u7+jrAbwU2bPd9RYtjzMc=;
        b=h1l1EtPJA+7RCZDF91+iI8JSdVZnhu5Ch79AlerWVdYCcRxxOsPUquvfs5TImG96wI
         tmamtYpZ2yZFMzrrYt1/e1UPH/Ee1MkD+I1jVWZxpgA8TnMqkfR12dascL3QevowrE02
         pNzivrfyqRUKCVOKsfuXv4kmdSPrHx6hKoqQEEU8x0aOLMjDnUTaIydNbahfOwOf/d3J
         Si5ysNpaWW5kcP99jlacj4SukhQxBXbJvCUodmBhe0Ayhs7bxcb4ZUIEDYrlMGH557Zk
         9sVrSjEnVK2CgCVZTmGxUYRGyyN4BtnJHC9+tS8Okovg9xk8hfA9XEvz3KmpUF7wqI7z
         JiCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYJ25Ic3Dds8OKyb4GRjKucogWEUw57mu3bO6ByuUAdyZnrr2W4r1U8N5xjSuMMCpHAvzN621c5lx8gmY0@vger.kernel.org, AJvYcCXPcXRXqUl2w/u+u+GhhgdMTM9zpGxKRQSBejYydPcEQCPJvPFQ499AjF/kSChi4gCCI/hVDb6SAGNHmTk=@vger.kernel.org, AJvYcCXc5yKtREkgJYjAm0nInIYb2C61S0G03DuKc5axqEFliTV3h4RJjGjK05jstCDLbHdMMXO9zultrshx@vger.kernel.org
X-Gm-Message-State: AOJu0YzcLdzJ3ZXmNj+9LB0uh6GxuYWhCpk7co48wmj9tIkQXQbMY2Tj
	dX9X0JZsKTSND1IXIdY8pwkCOe1A3MLgH7q1TNZiD+OvvmDJA6CGc+fM
X-Gm-Gg: ASbGnctWpbDRIl6Ikrrv0Xxo4kJHrCYUZqcf3AEE88L9p8NfTyup8KMJrdqnjcbiXvm
	ocinePv+XY6Flm4bbMe0sg6Eh7TH/sH3NWaoZLL7BTiGpwvUoou78tF5toOK68hz55BZ2KJqeel
	VYf9nGjx1pG0iG0SarchJ8OPOWgkjTOSGTvHck+fnRzoaYk2xOJK0CEX97z/Au1K35QQPBIG9aJ
	fvxHoPYPM+J/LYipCAjk+upb4JU9TNGhTa60p7T8xF89UFRXjamCvPWjPAFT/k+n24F2tYgTM29
	82oRoo/6NBgFhIDWlPLD9uPPgsXjSX/v9M8mwKcphbg8mTh4PVHKPwozd8tJqyBy6XyiUXI2WN1
	bP+5cheklP0a+gy9LRg==
X-Google-Smtp-Source: AGHT+IHqnfsOZvFsyKVagTm6yyvx16k+MRwlYKlP1gZJRca9O0R6SOizBJ3SLusgKBSDKjFy+FtGeQ==
X-Received: by 2002:a05:6902:4203:b0:e96:dcb9:d4d5 with SMTP id 3f1490d57ef6-e96e4793683mr6975836276.25.1756334569859;
        Wed, 27 Aug 2025 15:42:49 -0700 (PDT)
Received: from raspberrypi ([2600:1700:90:4c80::d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e0567840sm1707837276.4.2025.08.27.15.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:42:49 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:42:47 -0500
From: Grant Peltier <grantpeltier93@gmail.com>
To: linux@roeck-us.net
Cc: grant.peltier.jg@renesas.com, robh@kernel.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] docs: hwmon: add RAA228244 and RAA228246 info to
 isl68137 documentation
Message-ID: <ddeaf4d2fd1f9c85302ee9b5bf16cfaecf9b89ad.1756331945.git.grantpeltier93@gmail.com>
References: <cover.1756331945.git.grantpeltier93@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756331945.git.grantpeltier93@gmail.com>

The Renesas RAA228244 and RAA228246 are recently released digital
multiphase controllers.

Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
---
 Documentation/hwmon/isl68137.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/hwmon/isl68137.rst b/Documentation/hwmon/isl68137.rst
index 0e71b22047f8..5bc029c98383 100644
--- a/Documentation/hwmon/isl68137.rst
+++ b/Documentation/hwmon/isl68137.rst
@@ -374,6 +374,26 @@ Supported chips:
 
       Publicly available (after August 2020 launch) at the Renesas website
 
+  * Renesas RAA228244
+
+    Prefix: 'raa228244'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Provided by Renesas upon request and NDA
+
+  * Renesas RAA228246
+
+    Prefix: 'raa228246'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Provided by Renesas upon request and NDA
+
   * Renesas RAA229001
 
     Prefix: 'raa229001'
-- 
2.39.5


