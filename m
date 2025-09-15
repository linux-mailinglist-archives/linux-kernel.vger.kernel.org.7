Return-Path: <linux-kernel+bounces-816132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046ACB56FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962313B6792
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F8D2773E5;
	Mon, 15 Sep 2025 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ey9+Pde3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D926B97E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757915739; cv=none; b=deFVg1giVkqeL2Gv8wOYErA5sDESOxwFeSiWJuXa9vol3X9QXnx4VIYWOoV7VjeWPa5YeqVnEm6s51BrY/0qbpNL0q0PEcMAW9e8eNj76VaEP0RXUQ4Wr2gLdexUNl5q1jyO7sftnvP2peyOtRAReI6lq0lP4GlkfFltSmTw4Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757915739; c=relaxed/simple;
	bh=DbYsO7UJQJRjzTAl4hsAi+uv5Z0ebRu1GjxF1gpkvJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtVpTpprJ6c1IRb9TBFjqByNn+uT2Ec5MPns1YdzRUQpEU6p2qkMXMKmH5yHFk8ybLH5+nz5pIuthM/Kc7Ps+NizcSvWJ+WhpuMRKT1130EIG9exP+LLLpSU2PCdeMBCNz3Uy3W/plNHH9SeO2HjF5TxJlIFOecsba8dF91nQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ey9+Pde3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757915735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgzCsQOKmacoCjP/GBUfHiLtpkuIZsT3t9XMSe2iV7U=;
	b=Ey9+Pde3xvjEz/agHISwelVwUa2YRJmsIhgi6foc9d2dBPqSqD/57r9dzzx9L046IX8NCP
	8wWpEoFBYUbaYZrmbvhO2wxuQemmFxP2bhz+0LYBwdjVd313ZbsIgM6ccxwz5ncC17NM0x
	Npw6D6lQOXaO1+3WnPbQh+tMN4iS96c=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-bhCO57uPOsan3aqkds7Log-1; Mon, 15 Sep 2025 01:55:34 -0400
X-MC-Unique: bhCO57uPOsan3aqkds7Log-1
X-Mimecast-MFC-AGG-ID: bhCO57uPOsan3aqkds7Log_1757915733
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54a2ab0f2aso2068468a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 22:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757915733; x=1758520533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgzCsQOKmacoCjP/GBUfHiLtpkuIZsT3t9XMSe2iV7U=;
        b=Fu4s+75GmRC9HMDlosb4+FQ+cDZAECEzUQqKwGFwPegEGS5DwjtZGc1Znp4X+h5/JS
         iUWUwYmlk7mvtMKM27jhS4/jTiVZEJOpvkITXWRoQg4GAYzmR/OmaDaqIcglSOwWyOeH
         QjptVzs7GI+FX1Zw7RBRlC26NSCt18mUqo7h9SAbUrW1d4krJbBEjmWcY0peeDDFZp0f
         s8BK6m3kZlhTnCkLZt7NMnd8x7x5F+zWREzy26jmdlVryeT8Nv7IvIPnhW03d0UoeiCU
         gJO9VxTVLAj6YqFTUzBPC3fW6B3s4GzmnXxWrM1w1FYfIoZxj4OXZvAMkBk0wDbnzvww
         ps3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGgdGyoDdEVC+YtHFu3anuK09WjVHJB7EbWKXxnntBIksuGFpCnwasSBhZooWv4jXXfbifqeG493Jvmxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3798xu26XQ2KdsRXYHfCVZyQ5OTMKd1WNmRxRtl/PU1U0Xsg
	H4mvTW8FYkkH5RgqAcPeSVb/aI/lz15quohKW1t5BZis7tieAUDO98dadqwzkUZQmzL5FzggvjH
	rrC2ZzDdauWcmBPQXsqVYicOaYG+1DSkrK1CfNn22HXPnRfeAnCwiQCYhOIYyO5NxuibuxK4nhB
	vQuao=
X-Gm-Gg: ASbGncsl6ewRw0wcznlduR4GOJOKq0PL38b62O8kzbRptmSry4wjhKkgH73IZrB5m3k
	sZUF8u9bYGYRG21SKbKz3cZMi30y0qRs216ZL5SSOKkriyGmryTpCOz9pGRTie8e6EMeTT2IQ9E
	+W2lS7KyyjU1PPWaA7N3WpEsKewycCjkrAfP5pU/3e8IarB6HL8yDsAslyIIGN9FAJb2PhQntRZ
	sF19wHv7DT++R9jakHM74BzS9FvDz4Zb8FxAd0EaRtVFJNX6fz6HuscV2vrJumieGVCPRXnaoq/
	HfJqaQPun+9YYusZ6ET7Vye+KjlMLzo=
X-Received: by 2002:a05:6a20:548d:b0:248:7e43:b6b8 with SMTP id adf61e73a8af0-26027c23f44mr12880574637.3.1757915732979;
        Sun, 14 Sep 2025 22:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmcsBuNESqmUSaUAZsD1y3Jo2f26HFzeSrkABroCjauRovq1uR/BneKn5f+6zwo9yQ8EBy3Q==
X-Received: by 2002:a05:6a20:548d:b0:248:7e43:b6b8 with SMTP id adf61e73a8af0-26027c23f44mr12880551637.3.1757915732593;
        Sun, 14 Sep 2025 22:55:32 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77618a7feefsm8575003b3a.58.2025.09.14.22.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 22:55:32 -0700 (PDT)
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
Subject: [PATCH v3] ima: don't clear IMA_DIGSIG flag when setting or removing non-IMA xattr
Date: Mon, 15 Sep 2025 13:55:23 +0800
Message-ID: <20250915055524.2187783-1-coxu@redhat.com>
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
security.ima and then writes/removes some other security xattr for the
file.

For example, on Fedora, after booting the kernel with "ima_appraise=fix
evm=fix ima_policy=appraise_tcb" and installing rpm-plugin-ima,
installing/reinstalling a package will not make good reference IMA
signature generated. Instead IMA hash is generated,

    # getfattr -m - -d -e hex /usr/bin/bash
    # file: usr/bin/bash
    security.ima=0x0404...

This happens because when setting security.selinux, the IMA_DIGSIG flag
that had been set early was cleared. As a result, IMA hash is generated
when the file is closed.

Similarly, IMA signature can be cleared on file close after removing
security xattr like security.evm or setting/removing ACL.

Prevent replacing the IMA file signature with a file hash, by preventing
the IMA_DIGSIG flag from being reset.

Here's a minimal C reproducer which sets security.selinux as the last
step which can also replaced by removing security.evm or setting ACL,

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
 security/integrity/ima/ima_appraise.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..5149ff4fd50d 100644
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
@@ -807,7 +818,7 @@ static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			     const char *acl_name, struct posix_acl *kacl)
 {
 	if (evm_revalidate_status(acl_name))
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		ima_reset_appraise_flags(d_backing_inode(dentry), -1);
 
 	return 0;
 }
@@ -815,11 +826,13 @@ static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 static int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				 const char *xattr_name)
 {
-	int result;
+	int result, digsig = -1;
 
 	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		if (!strcmp(xattr_name, XATTR_NAME_IMA))
+			digsig = 0;
+		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
 		if (result == 1)
 			result = 0;
 	}

base-commit: 7aac71907bdea16e2754a782b9d9155449a9d49d
-- 
2.51.0


