Return-Path: <linux-kernel+bounces-805597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C88CEB48ABE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74B424E1705
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F176F2253F2;
	Mon,  8 Sep 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSpLr0gT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A09189
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329114; cv=none; b=RW0YTzMnXhsD/WLv29ydwRyIIuYn3/zm/VCOHOyjDk049wq36AW/UzePgLdKm5FCFjZEm+SKsoTzQ1DxORUsyzFJ35Pmah2JCsWBM6XoRN7qVyeNp+NjFWTQkX5BcEOO+k7C2vRNH6OX12sE+w/aUj3ngXGuJIDHYH5L+7n7v1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329114; c=relaxed/simple;
	bh=G44EIqcHlPc0MPwbyXEzw8SRNF12eQUABiDDCqEXD9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujm5us1eHWPWLitf0DPEXjv8Tp5Nu8GIk5JAmbGlmz0x3Je9fjxUnUwJw+yNe0Au3q7c4htIlVPNmrjpjdKkPRby6hypJa/qQT89ldvBcYMFbvA3sUpBLw87Ct3BUhbGbSCF4SuRHG/TWUeid9SapC37iORL14ODrL5S0+98I7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSpLr0gT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757329111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myamu423IxjnsnsnK8n7lFRHcKeofu6ER79sc7yqpzA=;
	b=RSpLr0gTZdmrQJ+eXTKzXSMMEllq3oG59wfyO31CsLytE5uqdEXPwhTh7yce/tQdIcchBg
	ftrSVeJzatNpYKFMfqbwgl2vU2boJrMOgkppDi5xvzGnFg/f2NQLL36mIXnJkK8uoDnr42
	iPC+q0pR6Nn/o3YYcj/2KBVusPV+ckE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-CHens0lVM0yrhRzSWrknKg-1; Mon, 08 Sep 2025 06:58:30 -0400
X-MC-Unique: CHens0lVM0yrhRzSWrknKg-1
X-Mimecast-MFC-AGG-ID: CHens0lVM0yrhRzSWrknKg_1757329109
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b521ae330b0so1675152a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757329109; x=1757933909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myamu423IxjnsnsnK8n7lFRHcKeofu6ER79sc7yqpzA=;
        b=JYTbYmOyp0ozV8aIgl9+5zP4tPIximX7V1h7TLJh0yjRXWAX5B+juzpPuTuEtAoNnt
         slEctZTdYu5FaMpkvVO2bGg+yYbO9I6vO9lnsJtd3Qohwr5mvGgbfp0pL1VefNbWD9Ll
         tiiI75Rgzg1+npCCsqJvMrX6oUgUbD9Hcxmlvjt0d+TXMxKSTG7QKBX9P3gmfK/NeQ9R
         pouOvCOZd7BRtFf5sdiCy0mq2zUgb/7XvBwHZKuQOCAYAj5NVY5m9DvujICYQfnQ3fNI
         FHzXLnc/JXZhSYlurp1JQ38hY8iVk6jDVPT5I33a54x1ul00AvhD9w/uTKD+netmWTDZ
         Wc0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL1ESyw/FV+WHE5ZaJqgzOiZD7i8MQmS4sVjIlsm8BOV9UX3/umGU/E44QxrF36tPv1fSe63ow7xcA+t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWTPbHgN3Yf5tER+WDrY6y8fTRCvqpy4XUn465QNKikBWN7pe
	Z32ZPiG9cr3j+J35FwyLcLCCXz0Iaq6e8LGWiF3ORZWkFrunDV9WlyDIz/nmpk41xAzXxrMkVB+
	glmidFmQVqyWns1Z3Bg/QrAN/cffqrpNHlZvMTfn7HMVJKVek1v2GiPe3Iu0B8z1a8w==
X-Gm-Gg: ASbGncvmkASzM9a7b5gdKthtbsBENzSDEvm9fWyGqOn8X0o9jVlfCnNdgtO2573h/WX
	4De9m4oeI1mzOdDJa/NXDCkvHqJiE7oLGcwEQJ5dFxvHfDzpR72q0x1GR8sh+d3Q9BhbbAmVgI1
	ncrpEJJ30x/bel3C/QumXSx+/hT4tSJtBlUtL1jTZnjQZ+glfCxCcl85SYB289G05i1reTBdbaC
	JbRHGYAM039PVhIW6uTAtjnBm0I+XLxzNFBBAJVOGop61LFtMLf/KOY3FhcNKe2Zxp8L9h9zKG8
	U76XLDU5vmO3ueo9bnH8PaIBHASQGgM=
X-Received: by 2002:a05:6a20:430b:b0:243:ce0f:e809 with SMTP id adf61e73a8af0-2533e94f9b6mr10495776637.23.1757329109183;
        Mon, 08 Sep 2025 03:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4DVeHGcV8BCDHrKD5vIE00IOinovx4zFRGm8WoZlYfoY+Z0xsXFPf2zD23vpJ0Ng5ZtHbYw==
X-Received: by 2002:a05:6a20:430b:b0:243:ce0f:e809 with SMTP id adf61e73a8af0-2533e94f9b6mr10495760637.23.1757329108797;
        Mon, 08 Sep 2025 03:58:28 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd092e2aasm25702026a12.21.2025.09.08.03.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:58:28 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ima: don't clear IMA_DIGSIG flag when setting non-IMA xattr
Date: Mon,  8 Sep 2025 18:58:24 +0800
Message-ID: <20250908105825.1573222-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902042515.759750-1-coxu@redhat.com>
References: <20250902042515.759750-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when both IMA and EVM are in fix mode, the IMA signature will
be reset to IMA hash if a program first stores IMA signature in
security.ima and then sets security.selinux for a file. For example, on
Fedora, after booting the kernel with "ima_appraise=fix evm=fix
ima_policy=appraise_tcb" and installing rpm-plugin-ima, reinstalling a
package will not make good reference IMA signature generated. Instead
IMA hash is generated,
    # getfattr -m - -d -e hex /usr/bin/bash
    # file: usr/bin/bash
    security.ima=0x0404...

This happens because when setting selinux.selinux, the IMA_DIGSIG flag
that had been set early was cleared. As a result, IMA hash is generated
when the file is closed.

Here's a minimal C reproducer,

    #include <stdio.h>
    #include <sys/xattr.h>
    #include <fcntl.h>
    #include <unistd.h>
    #include <string.h>
    #include <stdlib.h>

    int main() {
        const char* file_path = "/usr/sbin/test_binary";
        const char* hex_string = "030204d33204490066306402304";
        int length = strlen(hex_string);
        char* ima_attr_value;
        int fd;

        fd = open(file_path, O_WRONLY|O_CREAT|O_EXCL, 0644);
        if (fd == -1) {
            perror("Error opening file");
            return 1;
        }

        ima_attr_value = (char*)malloc(length / 2 );
        for (int i = 0, j = 0; i < length; i += 2, j++) {
            sscanf(hex_string + i, "%2hhx", &ima_attr_value[j]);
        }

        if (fsetxattr(fd, "security.ima", ima_attr_value, length/2, 0) == -1) {
            perror("Error setting extended attribute");
            close(fd);
            return 1;
        }

        const char* selinux_value= "system_u:object_r:bin_t:s0";
        if (fsetxattr(fd, "security.selinux", selinux_value, strlen(selinux_value), 0) == -1) {
            perror("Error setting extended attribute");
            close(fd);
            return 1;
        }

        close(fd);

        return 0;
    }

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/ima/ima_appraise.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..4e4750ea41ad 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -694,6 +694,15 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
 	return 0;
 }
 
+/*
+ * ima_reset_appraise_flags - reset ima_iint_cache flags
+ *
+ * @digsig: whether to clear/set IMA_DIGSIG flag, tristate values
+ *          0: clear IMA_DIGSIG
+ *          1: set IMA_DIGSIG
+ *         -1: don't change IMA_DIGSIG
+ *
+ */
 static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 {
 	struct ima_iint_cache *iint;
@@ -706,9 +715,9 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 		return;
 	iint->measured_pcrs = 0;
 	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
-	if (digsig)
+	if (digsig == 1)
 		set_bit(IMA_DIGSIG, &iint->atomic_flags);
-	else
+	else if (digsig == 0)
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 }
 
@@ -794,6 +803,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
 	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
 		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
+	} else {
+		digsig = -1;
 	}
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
-- 
2.51.0


