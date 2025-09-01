Return-Path: <linux-kernel+bounces-793644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE34B3D667
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB35189631D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A641F1537;
	Mon,  1 Sep 2025 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRKUHkSw"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB1EEC0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692037; cv=none; b=E0g4qOOyDCVJqzp2QJDc2iZd2YP+MWF8xii7+JCXTM0YePoVoGA+/E0rEzILvcVGy1fjIe0a5HeIisM7ireqrUIesyl7I+rJ5u/f54yMnD9Obj6hpZt6ZB3Ecr0jIYI3TXenUA6VqP/r+WCL8Sf/IPxfGlQ36GAo+A/HMFE5X7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692037; c=relaxed/simple;
	bh=JFo8kGIwRtM4b7ksy86xIAAJSCMLIBV+uUvzuPoFtZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FO5K742yY/6mehbvTal7No97UlNPHCt/0V3jFvD1Fb/5KorvXxRFsGqvHVGv0cfIz3CJboBRTRLkZ/X/DQPdbsBEdCpV04E4M2yAMkfbf2NrGQbq3f6cyz+/1OrTonEY6A+eHcfmEAhyFqGAnm/jeVWqnfRE4hIR8U9hnhKSdzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRKUHkSw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b33945989bso3403661cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756692035; x=1757296835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jyL2uYThEPRtr6lXtpANnQQKsvcDtp34Per6QbMgpNY=;
        b=dRKUHkSwlIEBpdA7p4CLYDOs+esjTjerLmRN2e/k53chtjj/gSjkOKOEGPvpKpH1kp
         X10Jmtrc6O2TGzfBG/hN5CQWajfWV94dWDZDR3VdgJpybycYbd6naSbqGyF5iZf9gfjQ
         X2wWslpWn0eTBtQZCQu4UVXnudSioVTWp5QqmfxyxQY0yge79ToQF2ZHuWEZH/4rlbgL
         ZmpBxxh9b4bd1R78VPqgFuLf+HsPGlO34Mf9DvsC5PfYwCKYASCa+VBY4pi8TH5QTNAQ
         WzRAgEgXUdCucbuvfHcgNDGYaL7kU4DkNuXDEfhW19l7Z+g84pW3PKq0P3OJHrFAul55
         gK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756692035; x=1757296835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyL2uYThEPRtr6lXtpANnQQKsvcDtp34Per6QbMgpNY=;
        b=Xn9zmNKaRPs+k0N4kObgK0M1j0pxMiKxp1bxAUuWkASbtpTqPG76Jyxph9v8kUHX8k
         OJPQyxK2bkeTqMoutZZF5Mcr7M9yyRJTCM30q/WL7Xxs67jyV8AS449nK58e7TkiUBr/
         7gJ++BRjXdJicUxDASjhQTVfqfWJYZBwXXisj/TqJXF/2JWwfvKepE8DnxeToDXngLSo
         UwTLuROvJHd6aaDa3hQP4wfd/Y/SU5Y2M4Hs9DiGcdA4ZbJwfzB8r/1VVl/1ec35gAcA
         iB4n0HppUbrUUkEduvhJ7ADY64RNUjr+Il6fpqNCYGJeU3knI9VyUXrSsJTYYJPthVJv
         Pgyg==
X-Gm-Message-State: AOJu0YzGWx7i5wbbTv0reioBU8b6Kpi6mPhloiOfS22OGDoHvX5DgYCx
	UkVM0WMPBcvDrmDFijUy4iHGQ3nrVxbx8nadLpbGxsLkwTZJ4Jl1/jwTaGtMMQ==
X-Gm-Gg: ASbGncunZqlp0WbtLlg1JuAU2Tgqb8DFaRbYxVcWSAfuiHS7Mr6KQ4QPq4ETk4/gS+I
	EBHYSN1mPu3Jh29Sejm7QztOmyaTkY4RvkN3abm+Lel8oTOVv42mLbPVaKUh+O25TY2tXs9ARVa
	msfijFXbHWDWRRu4uu7E7zI0XFy2wUyFLDyLeraMZN93GOKibuPgrBrGZQ/lgKv+nGJp7sQzF7C
	k2n9y1jV6kwIpphl6V+UBTTN9HrsGnGC+QyIFqBd3Wq8Tt5FluF/BvtzPQe9929/vnHX8aQC9aq
	5rYKSnaNNA0JE+g1e+ZmW0SDSu6SiXVf4iSYHmPjVjmjAIj5x9WVaIcA7FWGULO0Lr90+5t2eFv
	mWoMlz0+4yeXczjsI8SXYG+UsymRuisF8GRE4TwZXdQf12L5uVjI8xODohyrBPO1iQZhB
X-Google-Smtp-Source: AGHT+IGBf/gUhiHdnEw7YoC42PzQ3R5eHylJqJvn6AY/7oRJwAmgedwfLaIP9mmslF+b7vzYJ8ztbw==
X-Received: by 2002:a05:622a:102:b0:4b3:1c97:57ac with SMTP id d75a77b69052e-4b31dcbfe98mr72384491cf.80.1756692034502;
        Sun, 31 Aug 2025 19:00:34 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb25c80c0sm31910686d6.12.2025.08.31.19.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 19:00:34 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] auxdisplay: linedisp: support attribute attachment to auxdisplay devices
Date: Sun, 31 Aug 2025 22:00:24 -0400
Message-ID: <20250901020033.60196-1-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series modernizes the auxdisplay line display (linedisp) library to
enable seamless integration with auxdisplay parent devices while
maintaining backward compatibility.

The key improvement is adding attach/detach APIs that allow linedisp sysfs
attributes to be bound directly to their parent auxdisplay devices avoiding
child device proliferation and enabling a uniform 7-segment userspace
interface across different driver architectures.

This series introduces attachment infrastructure for linedisp devices.
The first consumer of this API will be the TM16XX driver series.
See the related patch series:
  auxdisplay: Add TM16xx 7-segment LED matrix display controllers driver

Changes include:
1. Encapsulate container_of() usage with to_linedisp() helper function for
   cleaner context retrieval
2. Improve message display behavior with static padding when message length
   is smaller than display width
3. Add 'num_chars' read-only attribute for userspace capability discovery
4. Add attach/detach API for sysfs attributes binding to parent devices
5. Document all linedisp sysfs attributes in ABI documentation

All existing linedisp_register() users remain unaffected. The new APIs
enable drivers like TM16XX to integrate 7-segment functionality within
their LED class device hierarchy while providing a uniform 7-segment API.

Thanks to Andy Shevchenko for early feedback and guidance.

RFC changelog:
- Replace scope_guard() with guard()() for synchronized list operations.
- Replace NULL assignments with proper list_entry_is_head() pattern.
- Clearly document why introducing the attach/detach APIs.
- Split in patch series, each patch containing a specific change.
- Implement static (non-scrolling) display for short messages.
- Document exisiting and new ABI sysfs attributes.

Jean-François Lessard (5):
  auxdisplay: linedisp: encapsulate container_of usage within
    to_linedisp
  auxdisplay: linedisp: display static message when length <= display
    size
  auxdisplay: linedisp: add num_chars sysfs attribute
  auxdisplay: linedisp: support attribute attachment to auxdisplay
    devices
  docs: ABI: auxdisplay: document linedisp library sysfs attributes

 .../ABI/testing/sysfs-auxdisplay-linedisp     |  90 +++++++
 drivers/auxdisplay/line-display.c             | 219 ++++++++++++++++--
 drivers/auxdisplay/line-display.h             |   4 +
 3 files changed, 295 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-auxdisplay-linedisp

-- 
2.43.0


