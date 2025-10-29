Return-Path: <linux-kernel+bounces-876530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372FDC1BAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3888F1897F18
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4446D33A02D;
	Wed, 29 Oct 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9myFAvq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37923358C7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751947; cv=none; b=avjVTSqxMcowdw8szUXkBDVT81Wv0R81e4GCNHH7YvHB7JlgPCqTSMu5UHJCb85jc3WJrwJlumlgFehG7hd4WIULXdnW6VFv06eyYw3KQMuhwsIUAw5fcZgXj+6s0OWGh7Cq8XfYryeiUZUDsVtLmhrkW0ELo/sEpgkM3P2MUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751947; c=relaxed/simple;
	bh=P7jmvuNkib4Grr1OK/vcBj2d8V6ba4O4XAeWod+DRi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXf1tnEMHqgHa3c0SciYSWOTupBUNc5hg0IJQSBXGiJ0RBO7xtNtvNzVzTvTGSxmBMKMcmHU/Pzc7/k/i3ThX6H9OnYae2nO/Y0+3HQNM2Yxw/6p9y3ng8skE4NR4/SUufWZYnlO5lCyjDTUQfkFFlBylvidyOk08EP1xg5V1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9myFAvq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761751944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4btZVR3J3shEYxkjDsr0KiT1KwXK3qj7K4l0C9+39Bo=;
	b=L9myFAvqtvEJ7nvCaI5Gh/GQxr95jMFZga5GuCZg/JY+RqKPAXyeTSiQZPT0qvovDMxI/R
	VQVSqnlxXP5emXLtV21F2sXQBudTk4Kb6ZwBkLCpnF0FeINPphiGgxSsGGNaiO7D7aVSbH
	W7DGJ1kr7PJT6nr6AblCf8AbSExot3k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-87pWm6YtM2GX0YvnKasBYw-1; Wed,
 29 Oct 2025 11:32:16 -0400
X-MC-Unique: 87pWm6YtM2GX0YvnKasBYw-1
X-Mimecast-MFC-AGG-ID: 87pWm6YtM2GX0YvnKasBYw_1761751934
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14AEB180A221;
	Wed, 29 Oct 2025 15:32:14 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.44.34.31])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 145271800579;
	Wed, 29 Oct 2025 15:32:08 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] dpll: Add support for phase adjustment granularity
Date: Wed, 29 Oct 2025 16:32:05 +0100
Message-ID: <20251029153207.178448-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Phase-adjust values are currently limited only by a min-max range. Some
hardware requires, for certain pin types, that values be multiples of
a specific granularity, as in the zl3073x driver.

Patch 1: Adds 'phase-adjust-gran' pin attribute and an appropriate
         handling
Patch 2: Adds a support for this attribute into zl3073x driver

Changes:
v2:
* changed type for the attribute to u32 and added explicit cast to s32 during
  remainder computation (per Jiri's request) 

Ivan Vecera (2):
  dpll: add phase-adjust-gran pin attribute
  dpll: zl3073x: Specify phase adjustment granularity for pins

 Documentation/driver-api/dpll.rst     | 36 +++++++++--------
 Documentation/netlink/specs/dpll.yaml |  7 ++++
 drivers/dpll/dpll_netlink.c           | 12 +++++-
 drivers/dpll/zl3073x/dpll.c           | 58 +++++++--------------------
 drivers/dpll/zl3073x/prop.c           | 11 +++++
 include/linux/dpll.h                  |  1 +
 include/uapi/linux/dpll.h             |  1 +
 7 files changed, 65 insertions(+), 61 deletions(-)

-- 
2.51.0


