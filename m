Return-Path: <linux-kernel+bounces-792410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C376B3C38A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12121752CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DEA230BCC;
	Fri, 29 Aug 2025 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfbb7CpM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190722068F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497677; cv=none; b=WuGuv2mrfFrPUA+slj023Xn2xbfAQPwrhgLDVNrH+UTkNH9EDUxKcaWxpILb7gAwTAru029z7yGuND2t85nlFqg2+22sT2QFYAwvX/sEU6hYXX9RW0UrZIE8hGAYGy332kBp7llOkNAfNabzsVPY6L0KYbqGP4g1Km4xOEzODao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497677; c=relaxed/simple;
	bh=TBkwEwPiRD6RNz5ZZVgOagyriUhD3MqyYjRhFF+JLf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmyT5Hv054GrgBgZv2hZ2AEDy9W6c0kCPG8Ow17F1Px2pMHL8iI/IeSTpoYtyJyqpaFI38ZwiwGqJNau0FuQ0ewjK56IrKaSyZSG/HUpZbqjDEPOQxBcqdrDI2HxszxlbbzWIqBKaMBI0NW7bEcahZ31LDwQlpdAkJrhqwVRLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kfbb7CpM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so349275066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756497672; x=1757102472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xWDvX4Tk8PYItt194kssyOcwkSba3SsSpA1uX2jnc4=;
        b=Kfbb7CpMTReTHkROFPI4H4UKEgxRnoUjIQLhbLxaUUS3U/IFcIov62zsFNPdh6+gzr
         qpGyQ7GBT62Mja+UlL7PKL+pDdGpsIt48cv53ZFNGtX/Zr4EtUDzkTU9ghuUU64pJJdE
         TMJzpy7Ya1b4o8TwR3OzZNdz5cIAa4kfAObg2hHajWl5A8Srx0cdQb/OGjR0+sLWgkOx
         zkVTb1LxVlX3/BBS2vsgqjakIjwLtEYF88dB0PG1S36vsujw0F6+6DXMiaa++R7rjqFj
         uSbCsd9kDmnKfctlnJnaV0ufoicK7X761Fq6K0pWYyUD0fITQg+tGqFHvNjCUqGWQeQw
         4d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756497672; x=1757102472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xWDvX4Tk8PYItt194kssyOcwkSba3SsSpA1uX2jnc4=;
        b=Gr4fJRK1U/Sb2rrucaxjjLJDAW/vCCpz3CN28zrlKU5PIcTEv7//kmO5RzrJqpI4hF
         YNbXJh3HGQx30q1geKEseX6W65qxltFH+04B5zrh3UDHGPnXUTKnokhf4YsUwy9vdd3B
         B1cGVYuPbVk8LZ3mEYqSmWfE1NnYuoInyMiAI37FSUdBw7Cua1I6veBKUjcXLagxTell
         QUge4QDKURVQWKEkDbk53xzuzuib8999iBeUluUZXW6c2r6j+fQKHX071SNgV+fg8dxv
         OwdCPDjC3yFMmoxK9MriC6uhFTEqjZVJsEWrq6JARSwnpWuA4HL/TU78pHc2Pj7ZmgbX
         lRdA==
X-Gm-Message-State: AOJu0YwDYOoQSuFsG/huoLu8L3EG09zeHfpK+1lFUJ/dt8NH5PXAZFBy
	lZzLP7yc37/MWWb+fhHOzs4SyRgOWZmNxEFfKmBpTXlO/KnEQ+MtSYC1
X-Gm-Gg: ASbGncsUHRRpnmF1xxwKUiYNYin7M6scX3fv4toSPP9BK/9OciOa9uwWyRBPGc/lcpZ
	18U6zRGlo/9pQV9i4EtdlJOfGU9kipHhZa10YR4tzKJnQyCgLHwkvOr1riIja6qnbgAXArPqTZ2
	MKCrjlN1zZ+a0wniG5t2I6vfSlE0KVSURdorp53p0EzSKhnH3O/Vt9h8FlLmL7+Lyg9TJ2ol9ZM
	5AL7e0QcBkJlhz7Rz/lDr2EvCI8cxBY5hTW/UIhxdsF32pNK9Vk37+66M039fQVIMI7aJscfUeS
	q5Ht0mA8vWGE9Lt37zvW9oUpqA7vgOFzmRzQc4WaiLdqKSqeDmNrrgAThE6Y/+yBFI09VSBhyap
	XBJMYppR+nO8wWuh53w+kyNTKq0+B+KSy9NeB/eFQiO5PoLHZ/FlJ1mEHaE0KWSpE041fLdmNiZ
	nc2fnl/J6wsKT71u0=
X-Google-Smtp-Source: AGHT+IGMbgJ9ZRpPt3tlKnU+yMR59xZbHfkXGR+Qu0TQD7T00LrlxVsrwdwvKYAFiwmb4S0kDs8BpA==
X-Received: by 2002:a17:907:9722:b0:afe:e745:c3b with SMTP id a640c23a62f3a-afee74512d3mr753502366b.12.1756497671804;
        Fri, 29 Aug 2025 13:01:11 -0700 (PDT)
Received: from XPS.. ([2a02:908:1b0:afe0:8c8d:46f1:a88d:88d5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7edfcasm267645566b.12.2025.08.29.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 13:01:11 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: gregkh@linuxfoundation.org,
	aleksander.lobakin@intel.com,
	sergio.paracuellos@gmail.com,
	pabeni@redhat.com,
	abhishektamboli9@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] staging: octeon: use fixed-width integer types
Date: Fri, 29 Aug 2025 22:01:07 +0200
Message-ID: <20250829200107.132443-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel coding style prefers fixed-width integer types defined in
<linux/types.h> (u8, u16, u32, u64, etc.) over the C99 stdint.h types
(e.g. uint64_t).

Replace uint64_t with u64, uint32_t with u32, uint16_t with u16
uint8_t with u8 in octeon-stubs.h.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 1745 +++++++++++++------------
 1 file changed, 873 insertions(+), 872 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 44cced319c11..ff6509b28cdd 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -43,144 +43,144 @@
 #define CVMX_POW_WQ_INT_PC		0
 
 union cvmx_pip_wqe_word2 {
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t bufs:8;
-		uint64_t ip_offset:8;
-		uint64_t vlan_valid:1;
-		uint64_t vlan_stacked:1;
-		uint64_t unassigned:1;
-		uint64_t vlan_cfi:1;
-		uint64_t vlan_id:12;
-		uint64_t pr:4;
-		uint64_t unassigned2:8;
-		uint64_t dec_ipcomp:1;
-		uint64_t tcp_or_udp:1;
-		uint64_t dec_ipsec:1;
-		uint64_t is_v6:1;
-		uint64_t software:1;
-		uint64_t L4_error:1;
-		uint64_t is_frag:1;
-		uint64_t IP_exc:1;
-		uint64_t is_bcast:1;
-		uint64_t is_mcast:1;
-		uint64_t not_IP:1;
-		uint64_t rcv_error:1;
-		uint64_t err_code:8;
+		u64 bufs:8;
+		u64 ip_offset:8;
+		u64 vlan_valid:1;
+		u64 vlan_stacked:1;
+		u64 unassigned:1;
+		u64 vlan_cfi:1;
+		u64 vlan_id:12;
+		u64 pr:4;
+		u64 unassigned2:8;
+		u64 dec_ipcomp:1;
+		u64 tcp_or_udp:1;
+		u64 dec_ipsec:1;
+		u64 is_v6:1;
+		u64 software:1;
+		u64 L4_error:1;
+		u64 is_frag:1;
+		u64 IP_exc:1;
+		u64 is_bcast:1;
+		u64 is_mcast:1;
+		u64 not_IP:1;
+		u64 rcv_error:1;
+		u64 err_code:8;
 	} s;
 	struct {
-		uint64_t bufs:8;
-		uint64_t ip_offset:8;
-		uint64_t vlan_valid:1;
-		uint64_t vlan_stacked:1;
-		uint64_t unassigned:1;
-		uint64_t vlan_cfi:1;
-		uint64_t vlan_id:12;
-		uint64_t port:12;
-		uint64_t dec_ipcomp:1;
-		uint64_t tcp_or_udp:1;
-		uint64_t dec_ipsec:1;
-		uint64_t is_v6:1;
-		uint64_t software:1;
-		uint64_t L4_error:1;
-		uint64_t is_frag:1;
-		uint64_t IP_exc:1;
-		uint64_t is_bcast:1;
-		uint64_t is_mcast:1;
-		uint64_t not_IP:1;
-		uint64_t rcv_error:1;
-		uint64_t err_code:8;
+		u64 bufs:8;
+		u64 ip_offset:8;
+		u64 vlan_valid:1;
+		u64 vlan_stacked:1;
+		u64 unassigned:1;
+		u64 vlan_cfi:1;
+		u64 vlan_id:12;
+		u64 port:12;
+		u64 dec_ipcomp:1;
+		u64 tcp_or_udp:1;
+		u64 dec_ipsec:1;
+		u64 is_v6:1;
+		u64 software:1;
+		u64 L4_error:1;
+		u64 is_frag:1;
+		u64 IP_exc:1;
+		u64 is_bcast:1;
+		u64 is_mcast:1;
+		u64 not_IP:1;
+		u64 rcv_error:1;
+		u64 err_code:8;
 	} s_cn68xx;
 
 	struct {
-		uint64_t unused1:16;
-		uint64_t vlan:16;
-		uint64_t unused2:32;
+		u64 unused1:16;
+		u64 vlan:16;
+		u64 unused2:32;
 	} svlan;
 	struct {
-		uint64_t bufs:8;
-		uint64_t unused:8;
-		uint64_t vlan_valid:1;
-		uint64_t vlan_stacked:1;
-		uint64_t unassigned:1;
-		uint64_t vlan_cfi:1;
-		uint64_t vlan_id:12;
-		uint64_t pr:4;
-		uint64_t unassigned2:12;
-		uint64_t software:1;
-		uint64_t unassigned3:1;
-		uint64_t is_rarp:1;
-		uint64_t is_arp:1;
-		uint64_t is_bcast:1;
-		uint64_t is_mcast:1;
-		uint64_t not_IP:1;
-		uint64_t rcv_error:1;
-		uint64_t err_code:8;
+		u64 bufs:8;
+		u64 unused:8;
+		u64 vlan_valid:1;
+		u64 vlan_stacked:1;
+		u64 unassigned:1;
+		u64 vlan_cfi:1;
+		u64 vlan_id:12;
+		u64 pr:4;
+		u64 unassigned2:12;
+		u64 software:1;
+		u64 unassigned3:1;
+		u64 is_rarp:1;
+		u64 is_arp:1;
+		u64 is_bcast:1;
+		u64 is_mcast:1;
+		u64 not_IP:1;
+		u64 rcv_error:1;
+		u64 err_code:8;
 	} snoip;
 
 };
 
 union cvmx_pip_wqe_word0 {
 	struct {
-		uint64_t next_ptr:40;
-		uint8_t unused;
+		u64 next_ptr:40;
+		u8 unused;
 		__wsum hw_chksum;
 	} cn38xx;
 	struct {
-		uint64_t pknd:6;        /* 0..5 */
-		uint64_t unused2:2;     /* 6..7 */
-		uint64_t bpid:6;        /* 8..13 */
-		uint64_t unused1:18;    /* 14..31 */
-		uint64_t l2ptr:8;       /* 32..39 */
-		uint64_t l3ptr:8;       /* 40..47 */
-		uint64_t unused0:8;     /* 48..55 */
-		uint64_t l4ptr:8;       /* 56..63 */
+		u64 pknd:6;        /* 0..5 */
+		u64 unused2:2;     /* 6..7 */
+		u64 bpid:6;        /* 8..13 */
+		u64 unused1:18;    /* 14..31 */
+		u64 l2ptr:8;       /* 32..39 */
+		u64 l3ptr:8;       /* 40..47 */
+		u64 unused0:8;     /* 48..55 */
+		u64 l4ptr:8;       /* 56..63 */
 	} cn68xx;
 };
 
 union cvmx_wqe_word0 {
-	uint64_t u64;
+	u64 u64;
 	union cvmx_pip_wqe_word0 pip;
 };
 
 union cvmx_wqe_word1 {
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t tag:32;
-		uint64_t tag_type:2;
-		uint64_t varies:14;
-		uint64_t len:16;
+		u64 tag:32;
+		u64 tag_type:2;
+		u64 varies:14;
+		u64 len:16;
 	};
 	struct {
-		uint64_t tag:32;
-		uint64_t tag_type:2;
-		uint64_t zero_2:3;
-		uint64_t grp:6;
-		uint64_t zero_1:1;
-		uint64_t qos:3;
-		uint64_t zero_0:1;
-		uint64_t len:16;
+		u64 tag:32;
+		u64 tag_type:2;
+		u64 zero_2:3;
+		u64 grp:6;
+		u64 zero_1:1;
+		u64 qos:3;
+		u64 zero_0:1;
+		u64 len:16;
 	} cn68xx;
 	struct {
-		uint64_t tag:32;
-		uint64_t tag_type:2;
-		uint64_t zero_2:1;
-		uint64_t grp:4;
-		uint64_t qos:3;
-		uint64_t ipprt:6;
-		uint64_t len:16;
+		u64 tag:32;
+		u64 tag_type:2;
+		u64 zero_2:1;
+		u64 grp:4;
+		u64 qos:3;
+		u64 ipprt:6;
+		u64 len:16;
 	} cn38xx;
 };
 
 union cvmx_buf_ptr {
 	void *ptr;
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t i:1;
-		uint64_t back:4;
-		uint64_t pool:3;
-		uint64_t size:16;
-		uint64_t addr:40;
+		u64 i:1;
+		u64 back:4;
+		u64 pool:3;
+		u64 size:16;
+		u64 addr:40;
 	} s;
 };
 
@@ -189,16 +189,16 @@ struct cvmx_wqe {
 	union cvmx_wqe_word1 word1;
 	union cvmx_pip_wqe_word2 word2;
 	union cvmx_buf_ptr packet_ptr;
-	uint8_t packet_data[96];
+	u8 packet_data[96];
 };
 
 union cvmx_helper_link_info {
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t reserved_20_63:44;
-		uint64_t link_up:1;	    /**< Is the physical link up? */
-		uint64_t full_duplex:1;	    /**< 1 if the link is full duplex */
-		uint64_t speed:18;	    /**< Speed of the link in Mbps */
+		u64 reserved_20_63:44;
+		u64 link_up:1;	    /**< Is the physical link up? */
+		u64 full_duplex:1;	    /**< 1 if the link is full duplex */
+		u64 speed:18;	    /**< Speed of the link in Mbps */
 	} s;
 };
 
@@ -262,921 +262,921 @@ enum cvmx_pow_tag_type {
 };
 
 union cvmx_ipd_ctl_status {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_ipd_ctl_status_s {
-		uint64_t reserved_18_63:46;
-		uint64_t use_sop:1;
-		uint64_t rst_done:1;
-		uint64_t clken:1;
-		uint64_t no_wptr:1;
-		uint64_t pq_apkt:1;
-		uint64_t pq_nabuf:1;
-		uint64_t ipd_full:1;
-		uint64_t pkt_off:1;
-		uint64_t len_m8:1;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_18_63:46;
+		u64 use_sop:1;
+		u64 rst_done:1;
+		u64 clken:1;
+		u64 no_wptr:1;
+		u64 pq_apkt:1;
+		u64 pq_nabuf:1;
+		u64 ipd_full:1;
+		u64 pkt_off:1;
+		u64 len_m8:1;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} s;
 	struct cvmx_ipd_ctl_status_cn30xx {
-		uint64_t reserved_10_63:54;
-		uint64_t len_m8:1;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_10_63:54;
+		u64 len_m8:1;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} cn30xx;
 	struct cvmx_ipd_ctl_status_cn38xxp2 {
-		uint64_t reserved_9_63:55;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_9_63:55;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} cn38xxp2;
 	struct cvmx_ipd_ctl_status_cn50xx {
-		uint64_t reserved_15_63:49;
-		uint64_t no_wptr:1;
-		uint64_t pq_apkt:1;
-		uint64_t pq_nabuf:1;
-		uint64_t ipd_full:1;
-		uint64_t pkt_off:1;
-		uint64_t len_m8:1;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_15_63:49;
+		u64 no_wptr:1;
+		u64 pq_apkt:1;
+		u64 pq_nabuf:1;
+		u64 ipd_full:1;
+		u64 pkt_off:1;
+		u64 len_m8:1;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} cn50xx;
 	struct cvmx_ipd_ctl_status_cn58xx {
-		uint64_t reserved_12_63:52;
-		uint64_t ipd_full:1;
-		uint64_t pkt_off:1;
-		uint64_t len_m8:1;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_12_63:52;
+		u64 ipd_full:1;
+		u64 pkt_off:1;
+		u64 len_m8:1;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} cn58xx;
 	struct cvmx_ipd_ctl_status_cn63xxp1 {
-		uint64_t reserved_16_63:48;
-		uint64_t clken:1;
-		uint64_t no_wptr:1;
-		uint64_t pq_apkt:1;
-		uint64_t pq_nabuf:1;
-		uint64_t ipd_full:1;
-		uint64_t pkt_off:1;
-		uint64_t len_m8:1;
-		uint64_t reset:1;
-		uint64_t addpkt:1;
-		uint64_t naddbuf:1;
-		uint64_t pkt_lend:1;
-		uint64_t wqe_lend:1;
-		uint64_t pbp_en:1;
-		uint64_t opc_mode:2;
-		uint64_t ipd_en:1;
+		u64 reserved_16_63:48;
+		u64 clken:1;
+		u64 no_wptr:1;
+		u64 pq_apkt:1;
+		u64 pq_nabuf:1;
+		u64 ipd_full:1;
+		u64 pkt_off:1;
+		u64 len_m8:1;
+		u64 reset:1;
+		u64 addpkt:1;
+		u64 naddbuf:1;
+		u64 pkt_lend:1;
+		u64 wqe_lend:1;
+		u64 pbp_en:1;
+		u64 opc_mode:2;
+		u64 ipd_en:1;
 	} cn63xxp1;
 };
 
 union cvmx_ipd_sub_port_fcs {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_ipd_sub_port_fcs_s {
-		uint64_t port_bit:32;
-		uint64_t reserved_32_35:4;
-		uint64_t port_bit2:4;
-		uint64_t reserved_40_63:24;
+		u64 port_bit:32;
+		u64 reserved_32_35:4;
+		u64 port_bit2:4;
+		u64 reserved_40_63:24;
 	} s;
 	struct cvmx_ipd_sub_port_fcs_cn30xx {
-		uint64_t port_bit:3;
-		uint64_t reserved_3_63:61;
+		u64 port_bit:3;
+		u64 reserved_3_63:61;
 	} cn30xx;
 	struct cvmx_ipd_sub_port_fcs_cn38xx {
-		uint64_t port_bit:32;
-		uint64_t reserved_32_63:32;
+		u64 port_bit:32;
+		u64 reserved_32_63:32;
 	} cn38xx;
 };
 
 union cvmx_ipd_sub_port_qos_cnt {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_ipd_sub_port_qos_cnt_s {
-		uint64_t cnt:32;
-		uint64_t port_qos:9;
-		uint64_t reserved_41_63:23;
+		u64 cnt:32;
+		u64 port_qos:9;
+		u64 reserved_41_63:23;
 	} s;
 };
 
 typedef struct {
-	uint32_t dropped_octets;
-	uint32_t dropped_packets;
-	uint32_t pci_raw_packets;
-	uint32_t octets;
-	uint32_t packets;
-	uint32_t multicast_packets;
-	uint32_t broadcast_packets;
-	uint32_t len_64_packets;
-	uint32_t len_65_127_packets;
-	uint32_t len_128_255_packets;
-	uint32_t len_256_511_packets;
-	uint32_t len_512_1023_packets;
-	uint32_t len_1024_1518_packets;
-	uint32_t len_1519_max_packets;
-	uint32_t fcs_align_err_packets;
-	uint32_t runt_packets;
-	uint32_t runt_crc_packets;
-	uint32_t oversize_packets;
-	uint32_t oversize_crc_packets;
-	uint32_t inb_packets;
-	uint64_t inb_octets;
-	uint16_t inb_errors;
+	u32 dropped_octets;
+	u32 dropped_packets;
+	u32 pci_raw_packets;
+	u32 octets;
+	u32 packets;
+	u32 multicast_packets;
+	u32 broadcast_packets;
+	u32 len_64_packets;
+	u32 len_65_127_packets;
+	u32 len_128_255_packets;
+	u32 len_256_511_packets;
+	u32 len_512_1023_packets;
+	u32 len_1024_1518_packets;
+	u32 len_1519_max_packets;
+	u32 fcs_align_err_packets;
+	u32 runt_packets;
+	u32 runt_crc_packets;
+	u32 oversize_packets;
+	u32 oversize_crc_packets;
+	u32 inb_packets;
+	u64 inb_octets;
+	u16 inb_errors;
 } cvmx_pip_port_status_t;
 
 typedef struct {
-	uint32_t packets;
-	uint64_t octets;
-	uint64_t doorbell;
+	u32 packets;
+	u64 octets;
+	u64 doorbell;
 } cvmx_pko_port_status_t;
 
 union cvmx_pip_frm_len_chkx {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_pip_frm_len_chkx_s {
-		uint64_t reserved_32_63:32;
-		uint64_t maxlen:16;
-		uint64_t minlen:16;
+		u64 reserved_32_63:32;
+		u64 maxlen:16;
+		u64 minlen:16;
 	} s;
 };
 
 union cvmx_gmxx_rxx_frm_ctl {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_gmxx_rxx_frm_ctl_s {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t vlan_len:1;
-		uint64_t pad_len:1;
-		uint64_t pre_align:1;
-		uint64_t null_dis:1;
-		uint64_t reserved_11_11:1;
-		uint64_t ptp_mode:1;
-		uint64_t reserved_13_63:51;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 vlan_len:1;
+		u64 pad_len:1;
+		u64 pre_align:1;
+		u64 null_dis:1;
+		u64 reserved_11_11:1;
+		u64 ptp_mode:1;
+		u64 reserved_13_63:51;
 	} s;
 	struct cvmx_gmxx_rxx_frm_ctl_cn30xx {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t vlan_len:1;
-		uint64_t pad_len:1;
-		uint64_t reserved_9_63:55;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 vlan_len:1;
+		u64 pad_len:1;
+		u64 reserved_9_63:55;
 	} cn30xx;
 	struct cvmx_gmxx_rxx_frm_ctl_cn31xx {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t vlan_len:1;
-		uint64_t reserved_8_63:56;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 vlan_len:1;
+		u64 reserved_8_63:56;
 	} cn31xx;
 	struct cvmx_gmxx_rxx_frm_ctl_cn50xx {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t reserved_7_8:2;
-		uint64_t pre_align:1;
-		uint64_t null_dis:1;
-		uint64_t reserved_11_63:53;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 reserved_7_8:2;
+		u64 pre_align:1;
+		u64 null_dis:1;
+		u64 reserved_11_63:53;
 	} cn50xx;
 	struct cvmx_gmxx_rxx_frm_ctl_cn56xxp1 {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t reserved_7_8:2;
-		uint64_t pre_align:1;
-		uint64_t reserved_10_63:54;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 reserved_7_8:2;
+		u64 pre_align:1;
+		u64 reserved_10_63:54;
 	} cn56xxp1;
 	struct cvmx_gmxx_rxx_frm_ctl_cn58xx {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t vlan_len:1;
-		uint64_t pad_len:1;
-		uint64_t pre_align:1;
-		uint64_t null_dis:1;
-		uint64_t reserved_11_63:53;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 vlan_len:1;
+		u64 pad_len:1;
+		u64 pre_align:1;
+		u64 null_dis:1;
+		u64 reserved_11_63:53;
 	} cn58xx;
 	struct cvmx_gmxx_rxx_frm_ctl_cn61xx {
-		uint64_t pre_chk:1;
-		uint64_t pre_strp:1;
-		uint64_t ctl_drp:1;
-		uint64_t ctl_bck:1;
-		uint64_t ctl_mcst:1;
-		uint64_t ctl_smac:1;
-		uint64_t pre_free:1;
-		uint64_t reserved_7_8:2;
-		uint64_t pre_align:1;
-		uint64_t null_dis:1;
-		uint64_t reserved_11_11:1;
-		uint64_t ptp_mode:1;
-		uint64_t reserved_13_63:51;
+		u64 pre_chk:1;
+		u64 pre_strp:1;
+		u64 ctl_drp:1;
+		u64 ctl_bck:1;
+		u64 ctl_mcst:1;
+		u64 ctl_smac:1;
+		u64 pre_free:1;
+		u64 reserved_7_8:2;
+		u64 pre_align:1;
+		u64 null_dis:1;
+		u64 reserved_11_11:1;
+		u64 ptp_mode:1;
+		u64 reserved_13_63:51;
 	} cn61xx;
 };
 
 union cvmx_gmxx_rxx_int_reg {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_gmxx_rxx_int_reg_s {
-		uint64_t minerr:1;
-		uint64_t carext:1;
-		uint64_t maxerr:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t alnerr:1;
-		uint64_t lenerr:1;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t niberr:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t phy_link:1;
-		uint64_t phy_spd:1;
-		uint64_t phy_dupx:1;
-		uint64_t pause_drp:1;
-		uint64_t loc_fault:1;
-		uint64_t rem_fault:1;
-		uint64_t bad_seq:1;
-		uint64_t bad_term:1;
-		uint64_t unsop:1;
-		uint64_t uneop:1;
-		uint64_t undat:1;
-		uint64_t hg2fld:1;
-		uint64_t hg2cc:1;
-		uint64_t reserved_29_63:35;
+		u64 minerr:1;
+		u64 carext:1;
+		u64 maxerr:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 alnerr:1;
+		u64 lenerr:1;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 niberr:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 phy_link:1;
+		u64 phy_spd:1;
+		u64 phy_dupx:1;
+		u64 pause_drp:1;
+		u64 loc_fault:1;
+		u64 rem_fault:1;
+		u64 bad_seq:1;
+		u64 bad_term:1;
+		u64 unsop:1;
+		u64 uneop:1;
+		u64 undat:1;
+		u64 hg2fld:1;
+		u64 hg2cc:1;
+		u64 reserved_29_63:35;
 	} s;
 	struct cvmx_gmxx_rxx_int_reg_cn30xx {
-		uint64_t minerr:1;
-		uint64_t carext:1;
-		uint64_t maxerr:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t alnerr:1;
-		uint64_t lenerr:1;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t niberr:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t phy_link:1;
-		uint64_t phy_spd:1;
-		uint64_t phy_dupx:1;
-		uint64_t reserved_19_63:45;
+		u64 minerr:1;
+		u64 carext:1;
+		u64 maxerr:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 alnerr:1;
+		u64 lenerr:1;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 niberr:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 phy_link:1;
+		u64 phy_spd:1;
+		u64 phy_dupx:1;
+		u64 reserved_19_63:45;
 	} cn30xx;
 	struct cvmx_gmxx_rxx_int_reg_cn50xx {
-		uint64_t reserved_0_0:1;
-		uint64_t carext:1;
-		uint64_t reserved_2_2:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t alnerr:1;
-		uint64_t reserved_6_6:1;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t niberr:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t phy_link:1;
-		uint64_t phy_spd:1;
-		uint64_t phy_dupx:1;
-		uint64_t pause_drp:1;
-		uint64_t reserved_20_63:44;
+		u64 reserved_0_0:1;
+		u64 carext:1;
+		u64 reserved_2_2:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 alnerr:1;
+		u64 reserved_6_6:1;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 niberr:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 phy_link:1;
+		u64 phy_spd:1;
+		u64 phy_dupx:1;
+		u64 pause_drp:1;
+		u64 reserved_20_63:44;
 	} cn50xx;
 	struct cvmx_gmxx_rxx_int_reg_cn52xx {
-		uint64_t reserved_0_0:1;
-		uint64_t carext:1;
-		uint64_t reserved_2_2:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t reserved_5_6:2;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t reserved_9_9:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t reserved_16_18:3;
-		uint64_t pause_drp:1;
-		uint64_t loc_fault:1;
-		uint64_t rem_fault:1;
-		uint64_t bad_seq:1;
-		uint64_t bad_term:1;
-		uint64_t unsop:1;
-		uint64_t uneop:1;
-		uint64_t undat:1;
-		uint64_t hg2fld:1;
-		uint64_t hg2cc:1;
-		uint64_t reserved_29_63:35;
+		u64 reserved_0_0:1;
+		u64 carext:1;
+		u64 reserved_2_2:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 reserved_5_6:2;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 reserved_9_9:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 reserved_16_18:3;
+		u64 pause_drp:1;
+		u64 loc_fault:1;
+		u64 rem_fault:1;
+		u64 bad_seq:1;
+		u64 bad_term:1;
+		u64 unsop:1;
+		u64 uneop:1;
+		u64 undat:1;
+		u64 hg2fld:1;
+		u64 hg2cc:1;
+		u64 reserved_29_63:35;
 	} cn52xx;
 	struct cvmx_gmxx_rxx_int_reg_cn56xxp1 {
-		uint64_t reserved_0_0:1;
-		uint64_t carext:1;
-		uint64_t reserved_2_2:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t reserved_5_6:2;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t reserved_9_9:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t reserved_16_18:3;
-		uint64_t pause_drp:1;
-		uint64_t loc_fault:1;
-		uint64_t rem_fault:1;
-		uint64_t bad_seq:1;
-		uint64_t bad_term:1;
-		uint64_t unsop:1;
-		uint64_t uneop:1;
-		uint64_t undat:1;
-		uint64_t reserved_27_63:37;
+		u64 reserved_0_0:1;
+		u64 carext:1;
+		u64 reserved_2_2:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 reserved_5_6:2;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 reserved_9_9:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 reserved_16_18:3;
+		u64 pause_drp:1;
+		u64 loc_fault:1;
+		u64 rem_fault:1;
+		u64 bad_seq:1;
+		u64 bad_term:1;
+		u64 unsop:1;
+		u64 uneop:1;
+		u64 undat:1;
+		u64 reserved_27_63:37;
 	} cn56xxp1;
 	struct cvmx_gmxx_rxx_int_reg_cn58xx {
-		uint64_t minerr:1;
-		uint64_t carext:1;
-		uint64_t maxerr:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t alnerr:1;
-		uint64_t lenerr:1;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t niberr:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t phy_link:1;
-		uint64_t phy_spd:1;
-		uint64_t phy_dupx:1;
-		uint64_t pause_drp:1;
-		uint64_t reserved_20_63:44;
+		u64 minerr:1;
+		u64 carext:1;
+		u64 maxerr:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 alnerr:1;
+		u64 lenerr:1;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 niberr:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 phy_link:1;
+		u64 phy_spd:1;
+		u64 phy_dupx:1;
+		u64 pause_drp:1;
+		u64 reserved_20_63:44;
 	} cn58xx;
 	struct cvmx_gmxx_rxx_int_reg_cn61xx {
-		uint64_t minerr:1;
-		uint64_t carext:1;
-		uint64_t reserved_2_2:1;
-		uint64_t jabber:1;
-		uint64_t fcserr:1;
-		uint64_t reserved_5_6:2;
-		uint64_t rcverr:1;
-		uint64_t skperr:1;
-		uint64_t reserved_9_9:1;
-		uint64_t ovrerr:1;
-		uint64_t pcterr:1;
-		uint64_t rsverr:1;
-		uint64_t falerr:1;
-		uint64_t coldet:1;
-		uint64_t ifgerr:1;
-		uint64_t reserved_16_18:3;
-		uint64_t pause_drp:1;
-		uint64_t loc_fault:1;
-		uint64_t rem_fault:1;
-		uint64_t bad_seq:1;
-		uint64_t bad_term:1;
-		uint64_t unsop:1;
-		uint64_t uneop:1;
-		uint64_t undat:1;
-		uint64_t hg2fld:1;
-		uint64_t hg2cc:1;
-		uint64_t reserved_29_63:35;
+		u64 minerr:1;
+		u64 carext:1;
+		u64 reserved_2_2:1;
+		u64 jabber:1;
+		u64 fcserr:1;
+		u64 reserved_5_6:2;
+		u64 rcverr:1;
+		u64 skperr:1;
+		u64 reserved_9_9:1;
+		u64 ovrerr:1;
+		u64 pcterr:1;
+		u64 rsverr:1;
+		u64 falerr:1;
+		u64 coldet:1;
+		u64 ifgerr:1;
+		u64 reserved_16_18:3;
+		u64 pause_drp:1;
+		u64 loc_fault:1;
+		u64 rem_fault:1;
+		u64 bad_seq:1;
+		u64 bad_term:1;
+		u64 unsop:1;
+		u64 uneop:1;
+		u64 undat:1;
+		u64 hg2fld:1;
+		u64 hg2cc:1;
+		u64 reserved_29_63:35;
 	} cn61xx;
 };
 
 union cvmx_gmxx_prtx_cfg {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_gmxx_prtx_cfg_s {
-		uint64_t reserved_22_63:42;
-		uint64_t pknd:6;
-		uint64_t reserved_14_15:2;
-		uint64_t tx_idle:1;
-		uint64_t rx_idle:1;
-		uint64_t reserved_9_11:3;
-		uint64_t speed_msb:1;
-		uint64_t reserved_4_7:4;
-		uint64_t slottime:1;
-		uint64_t duplex:1;
-		uint64_t speed:1;
-		uint64_t en:1;
+		u64 reserved_22_63:42;
+		u64 pknd:6;
+		u64 reserved_14_15:2;
+		u64 tx_idle:1;
+		u64 rx_idle:1;
+		u64 reserved_9_11:3;
+		u64 speed_msb:1;
+		u64 reserved_4_7:4;
+		u64 slottime:1;
+		u64 duplex:1;
+		u64 speed:1;
+		u64 en:1;
 	} s;
 	struct cvmx_gmxx_prtx_cfg_cn30xx {
-		uint64_t reserved_4_63:60;
-		uint64_t slottime:1;
-		uint64_t duplex:1;
-		uint64_t speed:1;
-		uint64_t en:1;
+		u64 reserved_4_63:60;
+		u64 slottime:1;
+		u64 duplex:1;
+		u64 speed:1;
+		u64 en:1;
 	} cn30xx;
 	struct cvmx_gmxx_prtx_cfg_cn52xx {
-		uint64_t reserved_14_63:50;
-		uint64_t tx_idle:1;
-		uint64_t rx_idle:1;
-		uint64_t reserved_9_11:3;
-		uint64_t speed_msb:1;
-		uint64_t reserved_4_7:4;
-		uint64_t slottime:1;
-		uint64_t duplex:1;
-		uint64_t speed:1;
-		uint64_t en:1;
+		u64 reserved_14_63:50;
+		u64 tx_idle:1;
+		u64 rx_idle:1;
+		u64 reserved_9_11:3;
+		u64 speed_msb:1;
+		u64 reserved_4_7:4;
+		u64 slottime:1;
+		u64 duplex:1;
+		u64 speed:1;
+		u64 en:1;
 	} cn52xx;
 };
 
 union cvmx_gmxx_rxx_adr_ctl {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_gmxx_rxx_adr_ctl_s {
-		uint64_t reserved_4_63:60;
-		uint64_t cam_mode:1;
-		uint64_t mcst:2;
-		uint64_t bcst:1;
+		u64 reserved_4_63:60;
+		u64 cam_mode:1;
+		u64 mcst:2;
+		u64 bcst:1;
 	} s;
 };
 
 union cvmx_pip_prt_tagx {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_pip_prt_tagx_s {
-		uint64_t reserved_54_63:10;
-		uint64_t portadd_en:1;
-		uint64_t inc_hwchk:1;
-		uint64_t reserved_50_51:2;
-		uint64_t grptagbase_msb:2;
-		uint64_t reserved_46_47:2;
-		uint64_t grptagmask_msb:2;
-		uint64_t reserved_42_43:2;
-		uint64_t grp_msb:2;
-		uint64_t grptagbase:4;
-		uint64_t grptagmask:4;
-		uint64_t grptag:1;
-		uint64_t grptag_mskip:1;
-		uint64_t tag_mode:2;
-		uint64_t inc_vs:2;
-		uint64_t inc_vlan:1;
-		uint64_t inc_prt_flag:1;
-		uint64_t ip6_dprt_flag:1;
-		uint64_t ip4_dprt_flag:1;
-		uint64_t ip6_sprt_flag:1;
-		uint64_t ip4_sprt_flag:1;
-		uint64_t ip6_nxth_flag:1;
-		uint64_t ip4_pctl_flag:1;
-		uint64_t ip6_dst_flag:1;
-		uint64_t ip4_dst_flag:1;
-		uint64_t ip6_src_flag:1;
-		uint64_t ip4_src_flag:1;
-		uint64_t tcp6_tag_type:2;
-		uint64_t tcp4_tag_type:2;
-		uint64_t ip6_tag_type:2;
-		uint64_t ip4_tag_type:2;
-		uint64_t non_tag_type:2;
-		uint64_t grp:4;
+		u64 reserved_54_63:10;
+		u64 portadd_en:1;
+		u64 inc_hwchk:1;
+		u64 reserved_50_51:2;
+		u64 grptagbase_msb:2;
+		u64 reserved_46_47:2;
+		u64 grptagmask_msb:2;
+		u64 reserved_42_43:2;
+		u64 grp_msb:2;
+		u64 grptagbase:4;
+		u64 grptagmask:4;
+		u64 grptag:1;
+		u64 grptag_mskip:1;
+		u64 tag_mode:2;
+		u64 inc_vs:2;
+		u64 inc_vlan:1;
+		u64 inc_prt_flag:1;
+		u64 ip6_dprt_flag:1;
+		u64 ip4_dprt_flag:1;
+		u64 ip6_sprt_flag:1;
+		u64 ip4_sprt_flag:1;
+		u64 ip6_nxth_flag:1;
+		u64 ip4_pctl_flag:1;
+		u64 ip6_dst_flag:1;
+		u64 ip4_dst_flag:1;
+		u64 ip6_src_flag:1;
+		u64 ip4_src_flag:1;
+		u64 tcp6_tag_type:2;
+		u64 tcp4_tag_type:2;
+		u64 ip6_tag_type:2;
+		u64 ip4_tag_type:2;
+		u64 non_tag_type:2;
+		u64 grp:4;
 	} s;
 	struct cvmx_pip_prt_tagx_cn30xx {
-		uint64_t reserved_40_63:24;
-		uint64_t grptagbase:4;
-		uint64_t grptagmask:4;
-		uint64_t grptag:1;
-		uint64_t reserved_30_30:1;
-		uint64_t tag_mode:2;
-		uint64_t inc_vs:2;
-		uint64_t inc_vlan:1;
-		uint64_t inc_prt_flag:1;
-		uint64_t ip6_dprt_flag:1;
-		uint64_t ip4_dprt_flag:1;
-		uint64_t ip6_sprt_flag:1;
-		uint64_t ip4_sprt_flag:1;
-		uint64_t ip6_nxth_flag:1;
-		uint64_t ip4_pctl_flag:1;
-		uint64_t ip6_dst_flag:1;
-		uint64_t ip4_dst_flag:1;
-		uint64_t ip6_src_flag:1;
-		uint64_t ip4_src_flag:1;
-		uint64_t tcp6_tag_type:2;
-		uint64_t tcp4_tag_type:2;
-		uint64_t ip6_tag_type:2;
-		uint64_t ip4_tag_type:2;
-		uint64_t non_tag_type:2;
-		uint64_t grp:4;
+		u64 reserved_40_63:24;
+		u64 grptagbase:4;
+		u64 grptagmask:4;
+		u64 grptag:1;
+		u64 reserved_30_30:1;
+		u64 tag_mode:2;
+		u64 inc_vs:2;
+		u64 inc_vlan:1;
+		u64 inc_prt_flag:1;
+		u64 ip6_dprt_flag:1;
+		u64 ip4_dprt_flag:1;
+		u64 ip6_sprt_flag:1;
+		u64 ip4_sprt_flag:1;
+		u64 ip6_nxth_flag:1;
+		u64 ip4_pctl_flag:1;
+		u64 ip6_dst_flag:1;
+		u64 ip4_dst_flag:1;
+		u64 ip6_src_flag:1;
+		u64 ip4_src_flag:1;
+		u64 tcp6_tag_type:2;
+		u64 tcp4_tag_type:2;
+		u64 ip6_tag_type:2;
+		u64 ip4_tag_type:2;
+		u64 non_tag_type:2;
+		u64 grp:4;
 	} cn30xx;
 	struct cvmx_pip_prt_tagx_cn50xx {
-		uint64_t reserved_40_63:24;
-		uint64_t grptagbase:4;
-		uint64_t grptagmask:4;
-		uint64_t grptag:1;
-		uint64_t grptag_mskip:1;
-		uint64_t tag_mode:2;
-		uint64_t inc_vs:2;
-		uint64_t inc_vlan:1;
-		uint64_t inc_prt_flag:1;
-		uint64_t ip6_dprt_flag:1;
-		uint64_t ip4_dprt_flag:1;
-		uint64_t ip6_sprt_flag:1;
-		uint64_t ip4_sprt_flag:1;
-		uint64_t ip6_nxth_flag:1;
-		uint64_t ip4_pctl_flag:1;
-		uint64_t ip6_dst_flag:1;
-		uint64_t ip4_dst_flag:1;
-		uint64_t ip6_src_flag:1;
-		uint64_t ip4_src_flag:1;
-		uint64_t tcp6_tag_type:2;
-		uint64_t tcp4_tag_type:2;
-		uint64_t ip6_tag_type:2;
-		uint64_t ip4_tag_type:2;
-		uint64_t non_tag_type:2;
-		uint64_t grp:4;
+		u64 reserved_40_63:24;
+		u64 grptagbase:4;
+		u64 grptagmask:4;
+		u64 grptag:1;
+		u64 grptag_mskip:1;
+		u64 tag_mode:2;
+		u64 inc_vs:2;
+		u64 inc_vlan:1;
+		u64 inc_prt_flag:1;
+		u64 ip6_dprt_flag:1;
+		u64 ip4_dprt_flag:1;
+		u64 ip6_sprt_flag:1;
+		u64 ip4_sprt_flag:1;
+		u64 ip6_nxth_flag:1;
+		u64 ip4_pctl_flag:1;
+		u64 ip6_dst_flag:1;
+		u64 ip4_dst_flag:1;
+		u64 ip6_src_flag:1;
+		u64 ip4_src_flag:1;
+		u64 tcp6_tag_type:2;
+		u64 tcp4_tag_type:2;
+		u64 ip6_tag_type:2;
+		u64 ip4_tag_type:2;
+		u64 non_tag_type:2;
+		u64 grp:4;
 	} cn50xx;
 };
 
 union cvmx_spxx_int_reg {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_spxx_int_reg_s {
-		uint64_t reserved_32_63:32;
-		uint64_t spf:1;
-		uint64_t reserved_12_30:19;
-		uint64_t calerr:1;
-		uint64_t syncerr:1;
-		uint64_t diperr:1;
-		uint64_t tpaovr:1;
-		uint64_t rsverr:1;
-		uint64_t drwnng:1;
-		uint64_t clserr:1;
-		uint64_t spiovr:1;
-		uint64_t reserved_2_3:2;
-		uint64_t abnorm:1;
-		uint64_t prtnxa:1;
+		u64 reserved_32_63:32;
+		u64 spf:1;
+		u64 reserved_12_30:19;
+		u64 calerr:1;
+		u64 syncerr:1;
+		u64 diperr:1;
+		u64 tpaovr:1;
+		u64 rsverr:1;
+		u64 drwnng:1;
+		u64 clserr:1;
+		u64 spiovr:1;
+		u64 reserved_2_3:2;
+		u64 abnorm:1;
+		u64 prtnxa:1;
 	} s;
 };
 
 union cvmx_spxx_int_msk {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_spxx_int_msk_s {
-		uint64_t reserved_12_63:52;
-		uint64_t calerr:1;
-		uint64_t syncerr:1;
-		uint64_t diperr:1;
-		uint64_t tpaovr:1;
-		uint64_t rsverr:1;
-		uint64_t drwnng:1;
-		uint64_t clserr:1;
-		uint64_t spiovr:1;
-		uint64_t reserved_2_3:2;
-		uint64_t abnorm:1;
-		uint64_t prtnxa:1;
+		u64 reserved_12_63:52;
+		u64 calerr:1;
+		u64 syncerr:1;
+		u64 diperr:1;
+		u64 tpaovr:1;
+		u64 rsverr:1;
+		u64 drwnng:1;
+		u64 clserr:1;
+		u64 spiovr:1;
+		u64 reserved_2_3:2;
+		u64 abnorm:1;
+		u64 prtnxa:1;
 	} s;
 };
 
 union cvmx_pow_wq_int {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_pow_wq_int_s {
-		uint64_t wq_int:16;
-		uint64_t iq_dis:16;
-		uint64_t reserved_32_63:32;
+		u64 wq_int:16;
+		u64 iq_dis:16;
+		u64 reserved_32_63:32;
 	} s;
 };
 
 union cvmx_sso_wq_int_thrx {
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t iq_thr:12;
-		uint64_t reserved_12_13:2;
-		uint64_t ds_thr:12;
-		uint64_t reserved_26_27:2;
-		uint64_t tc_thr:4;
-		uint64_t tc_en:1;
-		uint64_t reserved_33_63:31;
+		u64 iq_thr:12;
+		u64 reserved_12_13:2;
+		u64 ds_thr:12;
+		u64 reserved_26_27:2;
+		u64 tc_thr:4;
+		u64 tc_en:1;
+		u64 reserved_33_63:31;
 	} s;
 };
 
 union cvmx_stxx_int_reg {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_stxx_int_reg_s {
-		uint64_t reserved_9_63:55;
-		uint64_t syncerr:1;
-		uint64_t frmerr:1;
-		uint64_t unxfrm:1;
-		uint64_t nosync:1;
-		uint64_t diperr:1;
-		uint64_t datovr:1;
-		uint64_t ovrbst:1;
-		uint64_t calpar1:1;
-		uint64_t calpar0:1;
+		u64 reserved_9_63:55;
+		u64 syncerr:1;
+		u64 frmerr:1;
+		u64 unxfrm:1;
+		u64 nosync:1;
+		u64 diperr:1;
+		u64 datovr:1;
+		u64 ovrbst:1;
+		u64 calpar1:1;
+		u64 calpar0:1;
 	} s;
 };
 
 union cvmx_stxx_int_msk {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_stxx_int_msk_s {
-		uint64_t reserved_8_63:56;
-		uint64_t frmerr:1;
-		uint64_t unxfrm:1;
-		uint64_t nosync:1;
-		uint64_t diperr:1;
-		uint64_t datovr:1;
-		uint64_t ovrbst:1;
-		uint64_t calpar1:1;
-		uint64_t calpar0:1;
+		u64 reserved_8_63:56;
+		u64 frmerr:1;
+		u64 unxfrm:1;
+		u64 nosync:1;
+		u64 diperr:1;
+		u64 datovr:1;
+		u64 ovrbst:1;
+		u64 calpar1:1;
+		u64 calpar0:1;
 	} s;
 };
 
 union cvmx_pow_wq_int_pc {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_pow_wq_int_pc_s {
-		uint64_t reserved_0_7:8;
-		uint64_t pc_thr:20;
-		uint64_t reserved_28_31:4;
-		uint64_t pc:28;
-		uint64_t reserved_60_63:4;
+		u64 reserved_0_7:8;
+		u64 pc_thr:20;
+		u64 reserved_28_31:4;
+		u64 pc:28;
+		u64 reserved_60_63:4;
 	} s;
 };
 
 union cvmx_pow_wq_int_thrx {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_pow_wq_int_thrx_s {
-		uint64_t reserved_29_63:35;
-		uint64_t tc_en:1;
-		uint64_t tc_thr:4;
-		uint64_t reserved_23_23:1;
-		uint64_t ds_thr:11;
-		uint64_t reserved_11_11:1;
-		uint64_t iq_thr:11;
+		u64 reserved_29_63:35;
+		u64 tc_en:1;
+		u64 tc_thr:4;
+		u64 reserved_23_23:1;
+		u64 ds_thr:11;
+		u64 reserved_11_11:1;
+		u64 iq_thr:11;
 	} s;
 	struct cvmx_pow_wq_int_thrx_cn30xx {
-		uint64_t reserved_29_63:35;
-		uint64_t tc_en:1;
-		uint64_t tc_thr:4;
-		uint64_t reserved_18_23:6;
-		uint64_t ds_thr:6;
-		uint64_t reserved_6_11:6;
-		uint64_t iq_thr:6;
+		u64 reserved_29_63:35;
+		u64 tc_en:1;
+		u64 tc_thr:4;
+		u64 reserved_18_23:6;
+		u64 ds_thr:6;
+		u64 reserved_6_11:6;
+		u64 iq_thr:6;
 	} cn30xx;
 	struct cvmx_pow_wq_int_thrx_cn31xx {
-		uint64_t reserved_29_63:35;
-		uint64_t tc_en:1;
-		uint64_t tc_thr:4;
-		uint64_t reserved_20_23:4;
-		uint64_t ds_thr:8;
-		uint64_t reserved_8_11:4;
-		uint64_t iq_thr:8;
+		u64 reserved_29_63:35;
+		u64 tc_en:1;
+		u64 tc_thr:4;
+		u64 reserved_20_23:4;
+		u64 ds_thr:8;
+		u64 reserved_8_11:4;
+		u64 iq_thr:8;
 	} cn31xx;
 	struct cvmx_pow_wq_int_thrx_cn52xx {
-		uint64_t reserved_29_63:35;
-		uint64_t tc_en:1;
-		uint64_t tc_thr:4;
-		uint64_t reserved_21_23:3;
-		uint64_t ds_thr:9;
-		uint64_t reserved_9_11:3;
-		uint64_t iq_thr:9;
+		u64 reserved_29_63:35;
+		u64 tc_en:1;
+		u64 tc_thr:4;
+		u64 reserved_21_23:3;
+		u64 ds_thr:9;
+		u64 reserved_9_11:3;
+		u64 iq_thr:9;
 	} cn52xx;
 	struct cvmx_pow_wq_int_thrx_cn63xx {
-		uint64_t reserved_29_63:35;
-		uint64_t tc_en:1;
-		uint64_t tc_thr:4;
-		uint64_t reserved_22_23:2;
-		uint64_t ds_thr:10;
-		uint64_t reserved_10_11:2;
-		uint64_t iq_thr:10;
+		u64 reserved_29_63:35;
+		u64 tc_en:1;
+		u64 tc_thr:4;
+		u64 reserved_22_23:2;
+		u64 ds_thr:10;
+		u64 reserved_10_11:2;
+		u64 iq_thr:10;
 	} cn63xx;
 };
 
 union cvmx_npi_rsl_int_blocks {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_npi_rsl_int_blocks_s {
-		uint64_t reserved_32_63:32;
-		uint64_t rint_31:1;
-		uint64_t iob:1;
-		uint64_t reserved_28_29:2;
-		uint64_t rint_27:1;
-		uint64_t rint_26:1;
-		uint64_t rint_25:1;
-		uint64_t rint_24:1;
-		uint64_t asx1:1;
-		uint64_t asx0:1;
-		uint64_t rint_21:1;
-		uint64_t pip:1;
-		uint64_t spx1:1;
-		uint64_t spx0:1;
-		uint64_t lmc:1;
-		uint64_t l2c:1;
-		uint64_t rint_15:1;
-		uint64_t reserved_13_14:2;
-		uint64_t pow:1;
-		uint64_t tim:1;
-		uint64_t pko:1;
-		uint64_t ipd:1;
-		uint64_t rint_8:1;
-		uint64_t zip:1;
-		uint64_t dfa:1;
-		uint64_t fpa:1;
-		uint64_t key:1;
-		uint64_t npi:1;
-		uint64_t gmx1:1;
-		uint64_t gmx0:1;
-		uint64_t mio:1;
+		u64 reserved_32_63:32;
+		u64 rint_31:1;
+		u64 iob:1;
+		u64 reserved_28_29:2;
+		u64 rint_27:1;
+		u64 rint_26:1;
+		u64 rint_25:1;
+		u64 rint_24:1;
+		u64 asx1:1;
+		u64 asx0:1;
+		u64 rint_21:1;
+		u64 pip:1;
+		u64 spx1:1;
+		u64 spx0:1;
+		u64 lmc:1;
+		u64 l2c:1;
+		u64 rint_15:1;
+		u64 reserved_13_14:2;
+		u64 pow:1;
+		u64 tim:1;
+		u64 pko:1;
+		u64 ipd:1;
+		u64 rint_8:1;
+		u64 zip:1;
+		u64 dfa:1;
+		u64 fpa:1;
+		u64 key:1;
+		u64 npi:1;
+		u64 gmx1:1;
+		u64 gmx0:1;
+		u64 mio:1;
 	} s;
 	struct cvmx_npi_rsl_int_blocks_cn30xx {
-		uint64_t reserved_32_63:32;
-		uint64_t rint_31:1;
-		uint64_t iob:1;
-		uint64_t rint_29:1;
-		uint64_t rint_28:1;
-		uint64_t rint_27:1;
-		uint64_t rint_26:1;
-		uint64_t rint_25:1;
-		uint64_t rint_24:1;
-		uint64_t asx1:1;
-		uint64_t asx0:1;
-		uint64_t rint_21:1;
-		uint64_t pip:1;
-		uint64_t spx1:1;
-		uint64_t spx0:1;
-		uint64_t lmc:1;
-		uint64_t l2c:1;
-		uint64_t rint_15:1;
-		uint64_t rint_14:1;
-		uint64_t usb:1;
-		uint64_t pow:1;
-		uint64_t tim:1;
-		uint64_t pko:1;
-		uint64_t ipd:1;
-		uint64_t rint_8:1;
-		uint64_t zip:1;
-		uint64_t dfa:1;
-		uint64_t fpa:1;
-		uint64_t key:1;
-		uint64_t npi:1;
-		uint64_t gmx1:1;
-		uint64_t gmx0:1;
-		uint64_t mio:1;
+		u64 reserved_32_63:32;
+		u64 rint_31:1;
+		u64 iob:1;
+		u64 rint_29:1;
+		u64 rint_28:1;
+		u64 rint_27:1;
+		u64 rint_26:1;
+		u64 rint_25:1;
+		u64 rint_24:1;
+		u64 asx1:1;
+		u64 asx0:1;
+		u64 rint_21:1;
+		u64 pip:1;
+		u64 spx1:1;
+		u64 spx0:1;
+		u64 lmc:1;
+		u64 l2c:1;
+		u64 rint_15:1;
+		u64 rint_14:1;
+		u64 usb:1;
+		u64 pow:1;
+		u64 tim:1;
+		u64 pko:1;
+		u64 ipd:1;
+		u64 rint_8:1;
+		u64 zip:1;
+		u64 dfa:1;
+		u64 fpa:1;
+		u64 key:1;
+		u64 npi:1;
+		u64 gmx1:1;
+		u64 gmx0:1;
+		u64 mio:1;
 	} cn30xx;
 	struct cvmx_npi_rsl_int_blocks_cn38xx {
-		uint64_t reserved_32_63:32;
-		uint64_t rint_31:1;
-		uint64_t iob:1;
-		uint64_t rint_29:1;
-		uint64_t rint_28:1;
-		uint64_t rint_27:1;
-		uint64_t rint_26:1;
-		uint64_t rint_25:1;
-		uint64_t rint_24:1;
-		uint64_t asx1:1;
-		uint64_t asx0:1;
-		uint64_t rint_21:1;
-		uint64_t pip:1;
-		uint64_t spx1:1;
-		uint64_t spx0:1;
-		uint64_t lmc:1;
-		uint64_t l2c:1;
-		uint64_t rint_15:1;
-		uint64_t rint_14:1;
-		uint64_t rint_13:1;
-		uint64_t pow:1;
-		uint64_t tim:1;
-		uint64_t pko:1;
-		uint64_t ipd:1;
-		uint64_t rint_8:1;
-		uint64_t zip:1;
-		uint64_t dfa:1;
-		uint64_t fpa:1;
-		uint64_t key:1;
-		uint64_t npi:1;
-		uint64_t gmx1:1;
-		uint64_t gmx0:1;
-		uint64_t mio:1;
+		u64 reserved_32_63:32;
+		u64 rint_31:1;
+		u64 iob:1;
+		u64 rint_29:1;
+		u64 rint_28:1;
+		u64 rint_27:1;
+		u64 rint_26:1;
+		u64 rint_25:1;
+		u64 rint_24:1;
+		u64 asx1:1;
+		u64 asx0:1;
+		u64 rint_21:1;
+		u64 pip:1;
+		u64 spx1:1;
+		u64 spx0:1;
+		u64 lmc:1;
+		u64 l2c:1;
+		u64 rint_15:1;
+		u64 rint_14:1;
+		u64 rint_13:1;
+		u64 pow:1;
+		u64 tim:1;
+		u64 pko:1;
+		u64 ipd:1;
+		u64 rint_8:1;
+		u64 zip:1;
+		u64 dfa:1;
+		u64 fpa:1;
+		u64 key:1;
+		u64 npi:1;
+		u64 gmx1:1;
+		u64 gmx0:1;
+		u64 mio:1;
 	} cn38xx;
 	struct cvmx_npi_rsl_int_blocks_cn50xx {
-		uint64_t reserved_31_63:33;
-		uint64_t iob:1;
-		uint64_t lmc1:1;
-		uint64_t agl:1;
-		uint64_t reserved_24_27:4;
-		uint64_t asx1:1;
-		uint64_t asx0:1;
-		uint64_t reserved_21_21:1;
-		uint64_t pip:1;
-		uint64_t spx1:1;
-		uint64_t spx0:1;
-		uint64_t lmc:1;
-		uint64_t l2c:1;
-		uint64_t reserved_15_15:1;
-		uint64_t rad:1;
-		uint64_t usb:1;
-		uint64_t pow:1;
-		uint64_t tim:1;
-		uint64_t pko:1;
-		uint64_t ipd:1;
-		uint64_t reserved_8_8:1;
-		uint64_t zip:1;
-		uint64_t dfa:1;
-		uint64_t fpa:1;
-		uint64_t key:1;
-		uint64_t npi:1;
-		uint64_t gmx1:1;
-		uint64_t gmx0:1;
-		uint64_t mio:1;
+		u64 reserved_31_63:33;
+		u64 iob:1;
+		u64 lmc1:1;
+		u64 agl:1;
+		u64 reserved_24_27:4;
+		u64 asx1:1;
+		u64 asx0:1;
+		u64 reserved_21_21:1;
+		u64 pip:1;
+		u64 spx1:1;
+		u64 spx0:1;
+		u64 lmc:1;
+		u64 l2c:1;
+		u64 reserved_15_15:1;
+		u64 rad:1;
+		u64 usb:1;
+		u64 pow:1;
+		u64 tim:1;
+		u64 pko:1;
+		u64 ipd:1;
+		u64 reserved_8_8:1;
+		u64 zip:1;
+		u64 dfa:1;
+		u64 fpa:1;
+		u64 key:1;
+		u64 npi:1;
+		u64 gmx1:1;
+		u64 gmx0:1;
+		u64 mio:1;
 	} cn50xx;
 };
 
 union cvmx_pko_command_word0 {
-	uint64_t u64;
+	u64 u64;
 	struct {
-		uint64_t total_bytes:16;
-		uint64_t segs:6;
-		uint64_t dontfree:1;
-		uint64_t ignore_i:1;
-		uint64_t ipoffp1:7;
-		uint64_t gather:1;
-		uint64_t rsp:1;
-		uint64_t wqp:1;
-		uint64_t n2:1;
-		uint64_t le:1;
-		uint64_t reg0:11;
-		uint64_t subone0:1;
-		uint64_t reg1:11;
-		uint64_t subone1:1;
-		uint64_t size0:2;
-		uint64_t size1:2;
+		u64 total_bytes:16;
+		u64 segs:6;
+		u64 dontfree:1;
+		u64 ignore_i:1;
+		u64 ipoffp1:7;
+		u64 gather:1;
+		u64 rsp:1;
+		u64 wqp:1;
+		u64 n2:1;
+		u64 le:1;
+		u64 reg0:11;
+		u64 subone0:1;
+		u64 reg1:11;
+		u64 subone1:1;
+		u64 size0:2;
+		u64 size1:2;
 	} s;
 };
 
 union cvmx_ciu_timx {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_ciu_timx_s {
-		uint64_t reserved_37_63:27;
-		uint64_t one_shot:1;
-		uint64_t len:36;
+		u64 reserved_37_63:27;
+		u64 one_shot:1;
+		u64 len:36;
 	} s;
 };
 
 union cvmx_gmxx_rxx_rx_inbnd {
-	uint64_t u64;
+	u64 u64;
 	struct cvmx_gmxx_rxx_rx_inbnd_s {
-		uint64_t status:1;
-		uint64_t speed:2;
-		uint64_t duplex:1;
-		uint64_t reserved_4_63:60;
+		u64 status:1;
+		u64 speed:2;
+		u64 duplex:1;
+		u64 reserved_4_63:60;
 	} s;
 };
 
@@ -1194,12 +1194,12 @@ static inline void cvmx_fau_atomic_write32(enum cvmx_fau_reg_32 reg,
 					   int32_t value)
 { }
 
-static inline uint64_t cvmx_scratch_read64(uint64_t address)
+static inline u64 cvmx_scratch_read64(u64 address)
 {
 	return 0;
 }
 
-static inline void cvmx_scratch_write64(uint64_t address, uint64_t value)
+static inline void cvmx_scratch_write64(u64 address, u64 value)
 { }
 
 static inline int cvmx_wqe_get_grp(struct cvmx_wqe *work)
@@ -1207,7 +1207,7 @@ static inline int cvmx_wqe_get_grp(struct cvmx_wqe *work)
 	return 0;
 }
 
-static inline void *cvmx_phys_to_ptr(uint64_t physical_address)
+static inline void *cvmx_phys_to_ptr(u64 physical_address)
 {
 	return (void *)(uintptr_t)(physical_address);
 }
@@ -1230,12 +1230,12 @@ static inline int cvmx_helper_get_interface_index_num(int ipd_port)
 static inline void cvmx_fpa_enable(void)
 { }
 
-static inline uint64_t cvmx_read_csr(uint64_t csr_addr)
+static inline u64 cvmx_read_csr(u64 csr_addr)
 {
 	return 0;
 }
 
-static inline void cvmx_write_csr(uint64_t csr_addr, uint64_t val)
+static inline void cvmx_write_csr(u64 csr_addr, u64 val)
 { }
 
 static inline int cvmx_helper_setup_red(int pass_thresh, int drop_thresh)
@@ -1243,13 +1243,13 @@ static inline int cvmx_helper_setup_red(int pass_thresh, int drop_thresh)
 	return 0;
 }
 
-static inline void *cvmx_fpa_alloc(uint64_t pool)
+static inline void *cvmx_fpa_alloc(u64 pool)
 {
 	return NULL;
 }
 
-static inline void cvmx_fpa_free(void *ptr, uint64_t pool,
-				 uint64_t num_cache_lines)
+static inline void cvmx_fpa_free(void *ptr, u64 pool,
+				 u64 num_cache_lines)
 { }
 
 static inline int octeon_is_simulation(void)
@@ -1257,11 +1257,11 @@ static inline int octeon_is_simulation(void)
 	return 1;
 }
 
-static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
+static inline void cvmx_pip_get_port_status(u64 port_num, u64 clear,
 					    cvmx_pip_port_status_t *status)
 { }
 
-static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
+static inline void cvmx_pko_get_port_status(u64 port_num, u64 clear,
 					    cvmx_pko_port_status_t *status)
 { }
 
@@ -1367,7 +1367,7 @@ static inline int cvmx_spi_restart_interface(int interface,
 	return 0;
 }
 
-static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
+static inline void cvmx_fau_async_fetch_and_add32(u64 scraddr,
 						  enum cvmx_fau_reg_32 reg,
 						  int32_t value)
 { }
@@ -1380,12 +1380,13 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 	return r;
 }
 
-static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
+static inline void cvmx_pko_send_packet_prepare(u64 port, u64 queue,
 						cvmx_pko_lock_t use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
-		uint64_t queue, union cvmx_pko_command_word0 pko_command,
+static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(u64 port,
+							    u64 queue,
+								union cvmx_pko_command_word0 cmd,
 		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
 {
 	return 0;
@@ -1405,9 +1406,9 @@ static inline int cvmx_wqe_get_qos(struct cvmx_wqe *work)
 static inline void cvmx_wqe_set_grp(struct cvmx_wqe *work, int grp)
 { }
 
-static inline void cvmx_pow_work_submit(struct cvmx_wqe *wqp, uint32_t tag,
+static inline void cvmx_pow_work_submit(struct cvmx_wqe *wqp, u32 tag,
 					enum cvmx_pow_tag_type tag_type,
-					uint64_t qos, uint64_t grp)
+					u64 qos, u64 grp)
 { }
 
 #define CVMX_ASXX_RX_CLK_SETX(a, b)	((a) + (b))
-- 
2.43.0


