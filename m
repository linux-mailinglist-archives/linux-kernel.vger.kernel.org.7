Return-Path: <linux-kernel+bounces-882283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28C7C2A0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7023B1E9C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1799026B973;
	Mon,  3 Nov 2025 05:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4VD1FwC"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890EAD5A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147496; cv=none; b=UVqnAlxBVvTfvrrmMlUqpxVkyFk/4DN41eNYodb1db9L1oyIxQ1/xlH9RWfbfXCl1WkCFbAt5HLlTep8DYVCd4uf4Cvu7t1f+BV92Qgz9RNd9ai4CGGyWM5jNS4tygSnFNEWfB3vAMOSO1PSQYgOMzKzntIkh3nkJZqLMUtDIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147496; c=relaxed/simple;
	bh=uilIMW8H9xyz5+Zkt1AKDQxeML2GO3cuH76cUPnpI6k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NhJ5XWIb/Trzmleyr40e9xJJaIJT3/ciCnBWXTVW9ZhXMfjj0V8sRB25iOdjV3vzx3SxozvofM9nePcTYN6JAkJTHzE0mHxBn26H9ZmwVB4627oOPKLL0HROG2qk1UlaPFrlDn9K9U0Za0lJNMcNCv3P/+XZqCOvsN7Plv8hTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4VD1FwC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340bc4ef67fso2131879a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 21:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762147494; x=1762752294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YCP+d3HGNTVLSyaVEuAKYg438nXFEAHL1ebhNeuJAzg=;
        b=G4VD1FwCEZ4N72jGjY3t89dSUESe3PM0zX/3scLxw1ZTpTN3xwYIiSyvx+DXdbFV0X
         7nZPlApk26xDPrPHr2LI5nxF2dkFW3sc3Zfo1mzbJdJYpaOP1GH4pMYuei9If9Hgshxz
         SlOtPJ5zZHK2uIL2xJ+A4yy6AaLuAWaXLKDjO2232JtnWwIWqSHa11qQ+WsCnYdX8HDU
         k0L+oYHLHI9lJtJt/UQG2LS56Qtn1/6nYrRhoRvrJxpfI+VE7T+iZmegAjUDki1SGrBI
         GA5M9zXF8DWNLEtsRIEOfxvO5WKb8m9WJbmpdmfWQvih5wTfrNtq5Q3XA8dhDDxT3jgz
         pO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762147494; x=1762752294;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCP+d3HGNTVLSyaVEuAKYg438nXFEAHL1ebhNeuJAzg=;
        b=C8rFtfoT7ast1Emce5NH4fDIrj5+aoDcv6gYV6lKTr1TtM8m7tVcXAnbsqh2Uk5Td0
         pUu/zln/I0O3b++0dAkkOU73TX1vVDXdaSXMHxc/1CIOFpJudepgiZYPcCEQmYnLeOtz
         BXhPBNsSkOOc5UHgt8QZ3fnkUv+TByxEzM3wPX0bV3RwLOCMHs/fKwyt04p/x5vgL3Ye
         4uRL0Mrgy+dEfajhSmI5yh1sH8/UXD/zAQFuWRaZVOaZXSaJ980RSrr5QlL1s3NOCRw7
         abB0y8TtAXaJkNMGmHbS3J2UrPsnmTPIiWLtqKsjDTucc2LQi5SlU2JQ1RDWlLfEiFjg
         OqSg==
X-Forwarded-Encrypted: i=1; AJvYcCUsChFVY4qZkzsjYybp+e4lXy3HH/VzBoTNcLzDqL2iXQlbrCGohBClov2vPOUXYhU9zL8A3ZEnrc9P61g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9wBeGVlcw0bouQNOscF4hLwQHBY5RPZMzF4/n2F4C1xJKfKU
	NCKCHLMFjF8XvkFNuq2U75+cnJFzBr/U2L0hLQhVnF9IC9fy8+Dn6QBqfIl7VsK9MlqQBwuvpZe
	oPTxC6g==
X-Google-Smtp-Source: AGHT+IF7/Pn1hgg2i1g93sjcOH5bk7bVbGcbG0UO5+dnz2j8grS5JSSlFQ2hgGTC6kNaDPYXt9QbE67Lqy8=
X-Received: from plsl2.prod.google.com ([2002:a17:903:2442:b0:268:c82:4230])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2348:b0:272:c95c:866
 with SMTP id d9443c01a7336-2951a3b6b8amr164269915ad.20.1762147494261; Sun, 02
 Nov 2025 21:24:54 -0800 (PST)
Date: Mon,  3 Nov 2025 05:24:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103052450.1028813-1-badhri@google.com>
Subject: [PATCH v2 0/1] TCPM logbuffer wraparound
From: Badhri Jagan Sridharan <badhri@google.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	badhri@google.com
Cc: amitsd@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is a follow up on a previous discussion:
https://lore.kernel.org/lkml/20230410073134.488762-1-badhri@google.com/.

With this change, TCPM log buffer will now wrap around when full and
will not self-clear upon being read (dumped). A Kconfig option and a
corresponding debugfs file node are introduced to allow opt-in back to
the previous, non-wrapping, self-clearing behavior if required.
This is an interim step while TCPM logging infrastructure is migrated
to the standard event trace system. 

Badhri Jagan Sridharan (1):
  tcpm: Wraparound tcpm log and dont clear them when read

 drivers/usb/typec/tcpm/Kconfig |  8 ++++++
 drivers/usb/typec/tcpm/tcpm.c  | 51 ++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 2 deletions(-)


base-commit: 18514fd70ea4ca9de137bb3bceeac1bac4bcad75
-- 
2.51.1.930.gacf6e81ea2-goog


