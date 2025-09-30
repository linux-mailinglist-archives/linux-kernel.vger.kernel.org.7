Return-Path: <linux-kernel+bounces-837289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20119BABDF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35841C7DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC2B29E11A;
	Tue, 30 Sep 2025 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Qh4VCFZz"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8319BA3D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218223; cv=none; b=ucdbJcXE4AQZtju/HQywdM8eDcJMi1E5QTfh5a18X5tVCTFRmSVaOFR8IxtASsfR86f9x0elx0PD7J11uxWqUNzJUrU6fiJngF6CpzKU7X9bhGjofGy5+2xVw0WH7GTlIp8CroHz5HAADRUNqjzjVfQhuzK3Zh8E5Fotr3Js0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218223; c=relaxed/simple;
	bh=nbJwWa+vhhVNvUyItBLWI0379mRvEZ/DjPP/EB5PcHg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=F902Y600qzNPTVpvTsmoRlYNMaTkXUTqAclvMy6AkdTnQm5+7R0i5bW4O02ogRkAwSGzjf2CFg8i2GxtrrZg+rAKzMjHjHNxJoyhFGAV7Hz2LAbn36eLG3dLK9J9l6tbsX0HWhfZyAcDvH+cZaR31OJ2Oc9aQn1bFfVsk72q5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Qh4VCFZz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so1622386a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759218221; x=1759823021; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axSEZrnXl/WyQ4MMR1Y0hlJLy0n8pxTq1p3rAAO8pa0=;
        b=Qh4VCFZzROYIwT5ZUiSizBCvkd7X5rocUbauUGg23DyyDNPm/kyfaiPvcQdbBx1AGi
         2iZsBDg6ao5dmcU9Cj4gXu//OUiaMMrJThowr0RiFanH4ZgddndDVkW0cUrmhtb+ZQVD
         Y0TauBNOa2qbRHAotJcWMzz4XVYuo7CI3uJ+mQ73auNgVSPR5zXHhkdx69hkgGeyzXWD
         bY5nU+c+1K7Nl0IbZTnZEVUh/5nPS7kKNVv/botO/lt98XrFFCkF5LOMAJv8509QSLXg
         a+Ob0a+7mC+PaHSw5tZxNxFmDFH125hkGtwz16TmA5XVGxkcsgj0dxTIMV/5i3Yl+b8o
         YL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218221; x=1759823021;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axSEZrnXl/WyQ4MMR1Y0hlJLy0n8pxTq1p3rAAO8pa0=;
        b=E6V3Jtw2HVAu6SShBYWlWgduZK1B4t79tasK1WKvTWuNxniGsY1G3OXcf2sGOMqgnQ
         RsIDunlEciPqDI6PrjQEaucMxSxNTNeY2TegBXF7i7iRb5twQeXm9FPNJalZtwhp38Mo
         QsWPCi0ZL/5+PRPaO7j91X4L55hY8x0wtS6B8VqkaUH/qtmCG3Yn28V/9BxN73mrQfqL
         krIx+eXb0DKQsui187r6vhyQCag72r4d8LQsnm+5IFqec8TkTYypbfcGULXiTlGjwHSQ
         RQ4cKn/GGRy2KfuY30VODqtT1OHqf/pgKpFW0AqU3pTXVN3bTZzgdVVfbMH/q3JV/AgR
         kH0g==
X-Forwarded-Encrypted: i=1; AJvYcCWcgR49/KQSQ0rrwNPC7JmseM+BAHb4Ule+H6PC/xqCQiWHGHx9vWzDbPOc4fBPBiuIu+EhqDovmmwT8l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoeEovPazvZM/eqH125ik1h65g/or7WwLVnJn0wUyUdcEI9s/Z
	l0VQ2LeFbbazI1N2+I1wiK6QgfkfMpyHzKru/V909J1D0b5B4NEoS4FT3FLXOeSQNXDhmT25H5i
	ct9dX
X-Gm-Gg: ASbGncv1Ev9Qnj7FD2rW5Iv+VlJ+5wW5nPBO1gMEOhw6rA682KwPoZora3Tznds2xHr
	NH5SAbT8wzoAqRZQOFRMTGGuup0ozqjO8/LHAw0zq6yjKwg/PSDBfkd0e4l0H7VQgJ2OxMVj18B
	RLuH4Y9awPVJnrdG55OsnmgZ5xsHhIufaP/lIQfK6ONrkpDzVnoRHKXOsGkQUIamkB0/ncQHv+B
	RrjSQH1zrAF/yEOTWnBOcunC/tOqCwDHys8tkLNrcSAaUs09MhaeIN0xZakl4NwJrcvTmwTOfsB
	k5apj19SI2MD1Ptf+30ImdM+I9tU3bw1vwWSongJVyGvRehV1woqvG1pyVuoebAGDwx/7OoMGPz
	bWobPbgq4tRFEPpNsRo0Iy1SbbFBALuqQlSeJUmnBwNSbppoA2Etf+rOR5o3MV+A1QC+ie7Gm8b
	nsVKZLtHwPO1XaBVFDBW4WAsQ=
X-Google-Smtp-Source: AGHT+IHRGJdlwrgUn8z0FVOOqiAI6aN/EQorplmJHIi20oB6cflxPIMxeuYCJCaPdCg6cetvuv/Aag==
X-Received: by 2002:a17:90b:1644:b0:330:6d5e:f17e with SMTP id 98e67ed59e1d1-3342a2b94c2mr21467985a91.24.1759218220661;
        Tue, 30 Sep 2025 00:43:40 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-338386f577bsm3535374a91.2.2025.09.30.00.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:43:40 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: corey@minyard.net
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	guojinhui.liam@bytedance.com
Subject: [PATCH v2 0/3] ipmi: Close the race between __scan_channels() and deliver_response()
Date: Tue, 30 Sep 2025 15:42:36 +0800
Message-Id: <20250930074239.2353-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The command "ipmi -b -t" would occasionally fail:
  #ipmitool -b 6 -t 0x2c raw 0x6 0x01
  Unable to send command: Invalid argument
  Unable to send RAW command (channel=0x6 netfn=0x6 lun=0x0 cmd=0x1)

The race window between __scan_channels() and deliver_response() causes
the parameters of some channels to be set to 0.

Fix the race between __scan_channels() and deliver_response() with the
following changes.

1. Only assign intf->channel_list = intf->wchannels and set
   intf->channels_ready = true in channel_handler() after all channels_ready
   have been successfully scanned or after failing to send the IPMI
   request.
2. channel_handler() sets intf->channels_ready to true but no one clears
   it, preventing __scan_channels() from rescanning channels. When the BMC
   firmware changes a rescan is required. Allow it by clearing the flag
   before starting a new scan.
3. Channels remain static unless the BMC firmware changes. Skip channel
   rescan when no BMC firmware update has occurred.


v1: https://lore.kernel.org/all/20250929081602.1901-1-guojinhui.liam@bytedance.com/

Changelog in v1 -> v2 (suggested by corey):
 - Split the fix into three independent patches, each addressing a
   separate issue.
 - Clear intf->channels_ready only when the BMC firmware changes.

Jinhui Guo (3):
  ipmi: Fix the race between __scan_channels() and deliver_response()
  ipmi: Fix __scan_channels() failing to rescan channels
  ipmi: Skip channel scan if channels are already marked ready

 drivers/char/ipmi/ipmi_msghandler.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.20.1


