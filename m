Return-Path: <linux-kernel+bounces-837290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD69BABDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C648A16AE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B012BE7D5;
	Tue, 30 Sep 2025 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Iqj5tBk+"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C022BE7DC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218227; cv=none; b=u7g/1ieOJizrMAj7oTDBcOSccYjjIEB/h5wgjocqDFF/DQXMsjSHz6mZLWvkpDADmRRovx0uy7yazEx7JBdzP6+Bfc5B07BPsfYlNU3JBZDKhE+MAIwaHphKYZGfTLU2H8k+6vY+xNCeUu51dIEW8/JCI32DnL+cbnKty08Z7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218227; c=relaxed/simple;
	bh=XBNmMhEti5u5N9olH/YhkixwaEYi8hnuS7cZQWw0FYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=W3tg6gdmwSz2yEPMSpeKjdlaePLRNBsHvPTsOZyDsRw01zD/CjC9jz6OIZREHDpl4hXhaXCAN0C3+rCF4FLelVt97RRzDT9WJerGC1uyw24Lg0br7j80jiIYOu9pNT9nIEp5bT8WBCiXYID1cVO0MmlN57WnJw8TOKrqiB3p1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Iqj5tBk+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2698d47e776so48650135ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759218225; x=1759823025; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l+MFzw/am516PEFKIA1HZN/VZns9FQH6Q0OdRD4dEOQ=;
        b=Iqj5tBk+071xqER8EiofzGfa0ECllCL+migVaa0kUnTd9BOtrQM8DwvGgMqDeSIl6i
         ZDDUlcoXUz6N4mkJ/Dk05w5TdZ5FDIYw4TrKLTIHNxyyLMe9DOgbViDL2Yurmbaqu+M+
         6O62CvxjRtqu7T8WCXNtS+Aiyjst9I71c1PfzPNBurRjXKXXd2H31ICksBaLIg0tMtQF
         X0AuLFjE0U/LM5jT6K0upEMUCK2ZDQNA6uzSpUHbu80Ha00vval5hDxe2DyDUZopGNWy
         zr6FhRLUmdsUehc5o35GVEvCVQ3TW3QPFsH7tt4Jk7kXjBO2v1Y3VEuzZJvhVugddZ54
         YVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218225; x=1759823025;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+MFzw/am516PEFKIA1HZN/VZns9FQH6Q0OdRD4dEOQ=;
        b=IFlinYatygHOzR3THPwDvvnhnx/G8Hzs61tP3lakRQBgg69nTbDmahxt6p62ANon29
         46hz3+1n7HVo5QOsLliPggy7126RmirVD5PR0Hd1diHqJlzV6V+Lj1dgbB+XAAb0o867
         hSacoXOtikLVFg0BbgRhFi2kX/+GEXvkN0g2L3gvngBKhkYSIEBDidr0MaRDL0D0NJVc
         FHANXWeB5FmHTKt/9MWtfMVmiOq92RHlIwjAEJ52CE+3nDwmr0qp568GJxY623etmJ2R
         E0d0D7+QIuv5+l02RjiqsvfxyfjcIGTleanlSGeSlwyjtdiKUvNikIYV8mMLW8zVaA1j
         Cdpg==
X-Forwarded-Encrypted: i=1; AJvYcCWh/PtSotmwsC24lO+UbNUYOv1oSTptm/dsLH1ZFRiSOISId0C+RzAkFaDFybyZJMwrN8QMf5GKIj1S0vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfICeYJAV/ylBJ3M5AERzqQrgm4dAVQM4VU7j30eFkuRu/punt
	D3zmOKTN+qbU429GCDG1/yN20/6oIIbl5sT5BC6d3HDpOe+NouQUNLhAsAwQYD47rqH44R1Gn9N
	G5LEi
X-Gm-Gg: ASbGnctnXmok0XQMkP1WSH2mx+JuHzJSiJdF++fXrvQeRRa8TkCYZVVMJkgnR56Ic1J
	bj29jz4HVcKSphT/BMXFpy1dSiXjrLPwaL/h+twpSMasqrLnX4T5Jx4ZeESY3Unf6bMquOqP8SA
	SDlEsMgtPjFYSfFkJQdm3lh9FRNdpfRRX70zsl539fzZ9BDqWNc+4m5o5zR6CZJendaL257GIox
	x3/Hz8X0zUvg+jwHm/dfEbvfYjoNtxQdrK3AxWJi1if8KIqseDX3UeN1zmxVlkyG7Hp4Qm+tAD6
	dlxRckO5soKeSRW5CJltPZxoKuF5z9CWuPh5NQeHxCQUy+qcluPMaC3oE/JujR2mc80R3ibabUp
	iU8knIRXFIgJ1EalhELRO5G6+gFkzBOV3wgHPL7slaD0auIqbNbJ3lwp27MlyvAPp969dp/68sj
	+6bm9UTyVm3wafvaYH6Nq0M9g=
X-Google-Smtp-Source: AGHT+IEz5W4HFaTVSimEhs34yYbp0/rsgNJrvabhbkCWMxTkpZ90HkeOCYdscjnIU5ruvu9wBwJzwA==
X-Received: by 2002:a17:902:f64d:b0:259:5284:f87b with SMTP id d9443c01a7336-27ed49d0965mr208847315ad.16.1759218225403;
        Tue, 30 Sep 2025 00:43:45 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-338386f577bsm3535374a91.2.2025.09.30.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:43:44 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: corey@minyard.net
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	guojinhui.liam@bytedance.com
Subject: [PATCH v2 1/3] ipmi: Fix the race between __scan_channels() and deliver_response()
Date: Tue, 30 Sep 2025 15:42:37 +0800
Message-Id: <20250930074239.2353-2-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250930074239.2353-1-guojinhui.liam@bytedance.com>
References: <20250930074239.2353-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The race window between __scan_channels() and deliver_response() causes
the parameters of some channels to be set to 0.

1.[CPUA] __scan_channels() issues an IPMI request and waits with
         wait_event() until all channels have been scanned.
         wait_event() internally calls might_sleep(), which might
         yield the CPU. (Moreover, an interrupt can preempt
         wait_event() and force the task to yield the CPU.)
2.[CPUB] deliver_response() is invoked when the CPU receives the
         IPMI response. After processing a IPMI response,
         deliver_response() directly assigns intf->wchannels to
         intf->channel_list and sets intf->channels_ready to true.
         However, not all channels are actually ready for use.
3.[CPUA] Since intf->channels_ready is already true, wait_event()
         never enters __wait_event(). __scan_channels() immediately
         clears intf->null_user_handler and exits.
4.[CPUB] Once intf->null_user_handler is set to NULL, deliver_response()
         ignores further IPMI responses, leaving the remaining
	 channels zero-initialized and unusable.

CPUA                             CPUB
-------------------------------  -----------------------------
__scan_channels()
 intf->null_user_handler
       = channel_handler;
 send_channel_info_cmd(intf,
       0);
 wait_event(intf->waitq,
       intf->channels_ready);
  do {
   might_sleep();
                                 deliver_response()
                                  channel_handler()
                                   intf->channel_list =
				         intf->wchannels + set;
                                   intf->channels_ready = true;
                                   send_channel_info_cmd(intf,
                                         intf->curr_channel);
   if (condition)
    break;
   __wait_event(wq_head,
          condition);
  } while(0)
 intf->null_user_handler
       = NULL;
                                 deliver_response()
                                  if (!msg->user)
                                   if (intf->null_user_handler)
                                    rv = -EINVAL;
                                  return rv;
-------------------------------  -----------------------------

Fix the race between __scan_channels() and deliver_response() by
deferring both the assignment intf->channel_list = intf->wchannels
and the flag intf->channels_ready = true until all channels have
been successfully scanned or until the IPMI request has failed.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 8e9050f99e9e..a6e2e8246ab1 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3406,8 +3406,6 @@ channel_handler(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 			intf->channels_ready = true;
 			wake_up(&intf->waitq);
 		} else {
-			intf->channel_list = intf->wchannels + set;
-			intf->channels_ready = true;
 			rv = send_channel_info_cmd(intf, intf->curr_channel);
 		}
 
-- 
2.20.1


