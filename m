Return-Path: <linux-kernel+bounces-829606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32368B976F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494AF1B22A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B29230C34A;
	Tue, 23 Sep 2025 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B73wVImF"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F97309F0E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657655; cv=none; b=l488+v3DMjVOVHMVM96xazYn3QjMxBjbQ6KhDQ+qQq/6ors1ZW3HIpPaRwboP7LI/fCBenuVAx3jMupdi0WrNrhc3xGKsFx63Ut8kjQBGkXgARkVyMPJnqwNj9zmydda5rFrgzE1JoFndHNQsESXIUmZ8gT5V8rf9nS0LjgrDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657655; c=relaxed/simple;
	bh=C8XXts6akLb11nM2mMQrQ1mX2Cb7JSe8mH+9EyknL/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoA7SaEVqSmhX6sIWRPedX8fWNFE/QpDzo34qqZNQ/F7Ye4NO9Bsd/QM05+TcOse34o5fVdDnNiSU8WMR2r0VI4ndAEucv7eb46ZSgZZfKzrWONAdG7VVtKida1h7WODFZi3SjK+Jf5A5SN1vLARr4zlG/63XfQ74Xv+uCk5KaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B73wVImF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b2a159bcd94so57738266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657652; x=1759262452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFnHRlaDkZFQz8z/nxD9a5/SArA8MCeQHjKgdaq4v7Q=;
        b=B73wVImFx1/+bpOdlPvGQFEHw3yidTfo/uteXEpzUyPoDoqJO5G37eqXhHrdb+eNJ/
         8SburhE9p0/e34iNF29NQVr0H5ziQ2ov5Cqypk2naHOqWHHibdrLLEbB2I6oxaUMDjsC
         p2obl+iQhZCLZ0ZSP4iPXETSCYoj6Gl581BO0L1sG/Q/KAjIGMLB5M6VOOEIWh8hj4e9
         fDVVwTUmI7yFrtg29oXPGlr4HY1V9/xa4weclP5c+lS+bgoo+5buo+LKZ04Qgl/bnCfx
         MEi0A056FjNTGAfltLoSOdXZKBwhqlYQcM80mMoPsB4/sus4bqHQbknvp+Qbnp9mMkv0
         WqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657652; x=1759262452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFnHRlaDkZFQz8z/nxD9a5/SArA8MCeQHjKgdaq4v7Q=;
        b=Vl8U0g5gACDyeofrSSNI8tUCXMX3Nc2+ikRjEhYpPMyvDqy8cjxpdjMmvWs6hBc39a
         vVZupOho7HVNQ593Pu57fXrn+k1NFrIHVi08jCLJEdXGlUyVznmMHtG4DFhPBH2VtrAZ
         KgCnjl3VnLpdgTkrpPdCw/wVC/XM9urYu1Ak5moOgu1AlABoV7fNbfgd/fcVzstPJ3mo
         ph5f97q2HpT8nFywMNydKYN3iA4E7ZGCCRFdwzTTcI7VXgEHTfNtG3fSBuTNyDd12tgC
         VUd3dqyPEhjbP2SGlpEdPp6KEze2UrrK5460OOMmNwtjIiKBE2LAX8KWj9oXsI7Zt8Tp
         nhsA==
X-Forwarded-Encrypted: i=1; AJvYcCXxiWukkUPHhyaW3L7AB9TBslrTOijUXAR162Dkr/I41xYqZbOx/ylXlJzZbk2wLyO72wjWAUg3l4k2P20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1Ufa1g5g0M19XrknPugAaptlhNqwH6aQWzPPG86EMuzlVJmm
	dRhZ6ELqL/M3aqnS8p5vi/dxiFTFn10Tiz9wXmOdCZuuQYmtTAyRkxTu
X-Gm-Gg: ASbGncvYnnwnDmuBHPcUg1xqx6cz2qFzytykhwvcAF6/g3luun4C2pIW7vRn2BxYAln
	uaivX3jjyJl7M9feet8jdrf1PqkoNBkaNIRc1mI7lVOGtQpT/3BxyRDjgYssMJQ5U5BUY1U41ZN
	NqfMkWHovwn68H2w9ir2lPMVnibJ3Zn76ywBZcTD56sTo3l/D8S5n6jrdS8gcVOFYeAsKjIJWBL
	2y5k4dZVNw0Y5WKQU3dR1kAUYWb3n+vzu1isxmdQLWedYrl4Ly0xT1NUrrlIVogzqgQaelSnD3L
	pYdyUD+uBCNqXeSYe35crgtMdGQ0TTjQNaa3vj2fEjMgXkWiK2UyMVUJYv0K7zAiFlyI7GMX7ro
	JI6v4UtBfGJ01Om73xg0PlSAS
X-Google-Smtp-Source: AGHT+IGhKcZdV0r8YP2ON3pdAtvi9EACajla8mdLJY/F2fjwqzyOEqYb9k1Ezx6pq7ms/ARYTztc8Q==
X-Received: by 2002:a17:907:d8f:b0:b04:2d89:5d3a with SMTP id a640c23a62f3a-b302b80a6femr234862766b.7.1758657651892;
        Tue, 23 Sep 2025 13:00:51 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:51 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 3/4] uapi: netdev: Add XDP RX queue index metadata flags
Date: Tue, 23 Sep 2025 22:00:14 +0100
Message-ID: <20250923210026.3870-4-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added NETDEV_XDP_RX_METADATA_QUEUE_INDEX flag to both netdev.h files
for the bpf_xdp_metadata_rx_queue_index() function.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 include/uapi/linux/netdev.h       | 3 +++
 tools/include/uapi/linux/netdev.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 48eb49aa03d4..59033a607c16 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -46,11 +46,14 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_QUEUE_INDEX: Device is capable of exposing receive HW
+ *   queue index via bpf_xdp_metadata_rx_queue_index().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_QUEUE_INDEX = 8,
 };
 
 /**
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 48eb49aa03d4..59033a607c16 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -46,11 +46,14 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_QUEUE_INDEX: Device is capable of exposing receive HW
+ *   queue index via bpf_xdp_metadata_rx_queue_index().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_QUEUE_INDEX = 8,
 };
 
 /**
-- 
2.51.0


