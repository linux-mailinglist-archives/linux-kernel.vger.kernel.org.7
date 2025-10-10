Return-Path: <linux-kernel+bounces-848063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33061BCC638
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDE104F7016
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F082C3254;
	Fri, 10 Oct 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qPgzaUoE"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CC62C21FE
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089255; cv=none; b=R7BL81VYNY+9oZneOXIp12S/PvCT2JO7xRTFf3IUmC15yejons/wwumE8l6KIpiia60dDaS63DWiU6RKMJpoxCfZAOX6PiDp7Jg6nlWgrEa5nl2Gt4xUTi62zecCsU5AKp+3JOby/tPf96J2reqUQKCYHtSBPM10Pi8G1kLO+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089255; c=relaxed/simple;
	bh=8EZhlL01FhuzNxoVcXoMiAg4tsKnwNBj6nqCmsQ6zug=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=p+M2oWuf5euxaG+pvF0g3lch9mYhrwrI7ZgzWf6+bzLOHhOit4dfq9PgOB9+HPUj9qLoEEEKVBd9nbaYv9zwdvGedxewwJEn+WYq6PNPrLqoCAFy0rtA3YR9iV/U3bOHGsrKCBY+5yHROCV5UXSrt9m/FbZN66mZmdwYYfRX5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qPgzaUoE; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760089240; bh=5Lt2dD9dWAgsjYDrDAU5bpr/s/w0wHelHMNieI5Po7U=;
	h=From:To:Cc:Subject:Date;
	b=qPgzaUoEAar6jXjLkhv/eFe6hxn4+IJqOUHdxm4t5Dxx+5SbbKIs36NZgMTN31JHB
	 G3Eyli5R0zOinArh2qfFuqyh009wFp2CIqKRKPBsKK0y+2AD4q35DWRAU0rlwf6Am2
	 wUCf4haOIySLhjBMjHTGkz8kEb0IxGc+81M8A9eo=
Received: from localhost ([112.17.79.156])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id A2626059; Fri, 10 Oct 2025 17:40:38 +0800
X-QQ-mid: xmsmtpt1760089238t5naubr55
Message-ID: <tencent_EFD7AB9D703BE79101F219662337FC73EC05@qq.com>
X-QQ-XMAILINFO: NG7xP+P+sy64x0iIo3oOu8fhDNv4X6OMqectR9vdxjh71BB5adgjQ3s3zv9Ixs
	 EMVOVefnXyfq4sadEY7QTX69RYTS1ZaoCOVVMNQMCFVXWfrlPxvMpFbQC4Or22JRO8ukd95Mc6NR
	 GiMiCO93GUQhvtoy4ULrvIavaOf/bIaH46/yrkd23pG3j2Kk9Hch2tJAkHmGd/ZwZ7nvy61RYxwz
	 kOdjkWgaTBSLsTI+nqTqV1YkMclA1b1hmikcS2a6BAGgmmAULxHBPw7WO8k+UrqctgPCFxEkoFOO
	 KY4QSc/gVdC1Bipe6zuLpkw6M5NVL+XTL4ph2T+nUTJhTruj7K+uqgejiuFcTYSrqovrwhpFFTwZ
	 SvQ7tGGGQvX7vWXflCPLv1x8BSuoFdGvtFFyrZVGMPJ0KO3CZmDKLbv510+ouR/esfsWXxV+yZpf
	 oiim+aDAy26iSxjokO7+4pk8jC2Jtcb9e9lh42wouScubdpNl+iPgFPd/m8JBrPnaXnGOrK6FvcN
	 TvVYkrNn7Drbpc5xQO/Q6K/oQJk+q8p2fdR1rIMO3CAet5J+V4De4d90UGZyDnNv/Y/cFlP1NpZo
	 eeMQLYPGdApCBA6eVPR6+Y4woG+mUQq4HH7tOz94cuusEQNVVczgYUItsHMk/zwWR5XgMCM6r6RG
	 o0lRsmHhFugnkdoTewPA1mrBrwZfCxz1922MK58YLiuQFqcfL65R2bry1LDbIDHj/WeYDiLgVXxz
	 v0iXVG2Nh/E+8gSvdQjnltAOiUYmZa1UbelZ99uyeul+2LXLUTvy7ud+A2NWAzoYg84UtLFdeiHz
	 Z204zqJS+yNCCVVmJJOJGPMbKS/R0ybaRLTt3fNUizIhDF5ILnxlvIZbZFr9VkMEbO0CMHYGCktX
	 tmWaXxC9fGX1EGgb6fuXPpNJd9/TYA7C/KX6HBhlsUjBZO/mVZzbuXcq8sXkTm4/SAg8jbeNXrRs
	 jbCSxC3DMYzV0+gTkFp5bKLQBy83Me9WlBEULm3vtcabKE3JCM/0y/NqiuXkE2
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: lanyanzhi97@qq.com
To: linux-kernel@vger.kernel.org
Cc: Yanzhi Lan <lanyanzhi97@qq.com>
Subject: [PATCH] netlink: fix indentation and update NETLINK_* header comments
Date: Fri, 10 Oct 2025 17:40:36 +0800
X-OQ-MSGID: <20251010094036.136032-1-lanyanzhi97@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yanzhi Lan <lanyanzhi97@qq.com>

This patch fixes inconsistent indentation and updates the comments for
all NETLINK_* constants in include/uapi/linux/netlink.h.

Signed-off-by: Yanzhi Lan <lanyanzhi97@qq.com>
---
 include/uapi/linux/netlink.h       | 51 +++++++++++++++---------------
 tools/include/uapi/linux/netlink.h | 48 ++++++++++++++--------------
 2 files changed, 49 insertions(+), 50 deletions(-)

diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index f87aaf28a649..96824c61f0ce 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -6,39 +6,38 @@
 #include <linux/socket.h> /* for __kernel_sa_family_t */
 #include <linux/types.h>
 
-#define NETLINK_ROUTE		0	/* Routing/device hook				*/
-#define NETLINK_UNUSED		1	/* Unused number				*/
-#define NETLINK_USERSOCK	2	/* Reserved for user mode socket protocols 	*/
-#define NETLINK_FIREWALL	3	/* Unused number, formerly ip_queue		*/
-#define NETLINK_SOCK_DIAG	4	/* socket monitoring				*/
+#define NETLINK_ROUTE		0	/* Routing/device hook */
+#define NETLINK_UNUSED		1	/* Unused number */
+#define NETLINK_USERSOCK	2	/* Reserved for user mode socket protocols */
+#define NETLINK_FIREWALL	3	/* Unused number, formerly ip_queue */
+#define NETLINK_SOCK_DIAG	4	/* socket monitoring */
 #define NETLINK_NFLOG		5	/* netfilter/iptables ULOG */
-#define NETLINK_XFRM		6	/* ipsec */
+#define NETLINK_XFRM		6	/* IPsec framework */
 #define NETLINK_SELINUX		7	/* SELinux event notifications */
-#define NETLINK_ISCSI		8	/* Open-iSCSI */
-#define NETLINK_AUDIT		9	/* auditing */
-#define NETLINK_FIB_LOOKUP	10	
-#define NETLINK_CONNECTOR	11
-#define NETLINK_NETFILTER	12	/* netfilter subsystem */
-#define NETLINK_IP6_FW		13
-#define NETLINK_DNRTMSG		14	/* DECnet routing messages (obsolete) */
-#define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
-#define NETLINK_GENERIC		16
+#define NETLINK_ISCSI		8	/* Open-iSCSI notifications */
+#define NETLINK_AUDIT		9	/* auditing subsystem messages */
+#define NETLINK_FIB_LOOKUP	10	/* FIB lookup (used by routing daemons) */
+#define NETLINK_CONNECTOR	11	/* Connector for kernel <-> userspace */
+#define NETLINK_NETFILTER	12	/* netfilter subsystem messages */
+#define NETLINK_IP6_FW		13	/* IPv6 firewall notifications (legacy) */
+#define NETLINK_DNRTMSG		14	/* DECnet routing messages */
+#define NETLINK_KOBJECT_UEVENT	15	/* Kernel uevent messages to userspace */
+#define NETLINK_GENERIC		16  /* Generic netlink family */
 /* leave room for NETLINK_DM (DM Events) */
-#define NETLINK_SCSITRANSPORT	18	/* SCSI Transports */
-#define NETLINK_ECRYPTFS	19
-#define NETLINK_RDMA		20
-#define NETLINK_CRYPTO		21	/* Crypto layer */
-#define NETLINK_SMC		22	/* SMC monitoring */
-
+#define NETLINK_SCSITRANSPORT	18	/* SCSI transport notifications */
+#define NETLINK_ECRYPTFS	19	/* eCryptfs filesystem notifications */
+#define NETLINK_RDMA		20	/* RDMA subsystem notifications */
+#define NETLINK_CRYPTO		21	/* Crypto layer messages */
+#define NETLINK_SMC			22	/* SMC monitoring */
 #define NETLINK_INET_DIAG	NETLINK_SOCK_DIAG
 
-#define MAX_LINKS 32		
+#define MAX_LINKS 32
 
 struct sockaddr_nl {
-	__kernel_sa_family_t	nl_family;	/* AF_NETLINK	*/
-	unsigned short	nl_pad;		/* zero		*/
-	__u32		nl_pid;		/* port ID	*/
-       	__u32		nl_groups;	/* multicast groups mask */
+	__kernel_sa_family_t	nl_family;	/* AF_NETLINK */
+	unsigned short	nl_pad;		/* zero */
+	__u32		nl_pid;		/* port ID */
+	__u32		nl_groups;	/* multicast groups mask */
 };
 
 /**
diff --git a/tools/include/uapi/linux/netlink.h b/tools/include/uapi/linux/netlink.h
index 0a4d73317759..2650517af44c 100644
--- a/tools/include/uapi/linux/netlink.h
+++ b/tools/include/uapi/linux/netlink.h
@@ -6,39 +6,39 @@
 #include <linux/socket.h> /* for __kernel_sa_family_t */
 #include <linux/types.h>
 
-#define NETLINK_ROUTE		0	/* Routing/device hook				*/
-#define NETLINK_UNUSED		1	/* Unused number				*/
-#define NETLINK_USERSOCK	2	/* Reserved for user mode socket protocols 	*/
-#define NETLINK_FIREWALL	3	/* Unused number, formerly ip_queue		*/
-#define NETLINK_SOCK_DIAG	4	/* socket monitoring				*/
+#define NETLINK_ROUTE		0	/* Routing/device hook */
+#define NETLINK_UNUSED		1	/* Unused number */
+#define NETLINK_USERSOCK	2	/* Reserved for user mode socket protocols */
+#define NETLINK_FIREWALL	3	/* Unused number, formerly ip_queue */
+#define NETLINK_SOCK_DIAG	4	/* socket monitoring */
 #define NETLINK_NFLOG		5	/* netfilter/iptables ULOG */
-#define NETLINK_XFRM		6	/* ipsec */
+#define NETLINK_XFRM		6	/* IPsec framework */
 #define NETLINK_SELINUX		7	/* SELinux event notifications */
-#define NETLINK_ISCSI		8	/* Open-iSCSI */
-#define NETLINK_AUDIT		9	/* auditing */
-#define NETLINK_FIB_LOOKUP	10	
-#define NETLINK_CONNECTOR	11
-#define NETLINK_NETFILTER	12	/* netfilter subsystem */
-#define NETLINK_IP6_FW		13
+#define NETLINK_ISCSI		8	/* Open-iSCSI notifications */
+#define NETLINK_AUDIT		9	/* auditing subsystem messages */
+#define NETLINK_FIB_LOOKUP	10	/* FIB lookup (used by routing daemons) */
+#define NETLINK_CONNECTOR	11	/* Connector for kernel <-> userspace */
+#define NETLINK_NETFILTER	12	/* netfilter subsystem messages */
+#define NETLINK_IP6_FW		13	/* IPv6 firewall notifications (legacy) */
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
-#define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
-#define NETLINK_GENERIC		16
+#define NETLINK_KOBJECT_UEVENT	15	/* Kernel uevent messages to userspace */
+#define NETLINK_GENERIC		16  /* Generic netlink family */
 /* leave room for NETLINK_DM (DM Events) */
-#define NETLINK_SCSITRANSPORT	18	/* SCSI Transports */
-#define NETLINK_ECRYPTFS	19
-#define NETLINK_RDMA		20
-#define NETLINK_CRYPTO		21	/* Crypto layer */
-#define NETLINK_SMC		22	/* SMC monitoring */
+#define NETLINK_SCSITRANSPORT	18	/* SCSI transport notifications */
+#define NETLINK_ECRYPTFS	19	/* eCryptfs filesystem notifications */
+#define NETLINK_RDMA		20	/* RDMA subsystem notifications */
+#define NETLINK_CRYPTO		21	/* Crypto layer messages */
+#define NETLINK_SMC			22	/* SMC monitoring */
 
 #define NETLINK_INET_DIAG	NETLINK_SOCK_DIAG
 
-#define MAX_LINKS 32		
+#define MAX_LINKS 32
 
 struct sockaddr_nl {
-	__kernel_sa_family_t	nl_family;	/* AF_NETLINK	*/
-	unsigned short	nl_pad;		/* zero		*/
-	__u32		nl_pid;		/* port ID	*/
-       	__u32		nl_groups;	/* multicast groups mask */
+	__kernel_sa_family_t	nl_family;	/* AF_NETLINK */
+	unsigned short	nl_pad;		/* zero */
+	__u32		nl_pid;		/* port ID */
+	__u32		nl_groups;	/* multicast groups mask */
 };
 
 struct nlmsghdr {
-- 
2.43.0


