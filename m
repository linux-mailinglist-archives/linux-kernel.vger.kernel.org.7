Return-Path: <linux-kernel+bounces-841162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC1BB65F7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BEA6344AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77092BE652;
	Fri,  3 Oct 2025 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tl0AS49R"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB9928643E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483850; cv=none; b=cms9zwZtmVEuaaRXCRjCDPEwyyW65ZILAcz0C1RY6SYlGZAX+9KpBmBb5S6qwep0jWpBJBhvVdLqTixvftuPHZN6w/osMe9YLSThr6DGzMlad1HuQ0J+i2QPls5SE+Q0zu1FYFwhaDeWsZn6Mu+vAFX6r5ZDGOTaANGpsH4Bymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483850; c=relaxed/simple;
	bh=DAoVlV27WWlmXjiBC9nMRy5Zf/pHsEoBLiOFORFTr2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LZWK1FK1Aj+P+PNTCX/uTUSdO7dPSo+vWDJLTi+6SZoDc08T8/YTuFSnDAOQbufALRmuKv5U41/QDUuSCyMuxaGSMRSkGYWSSOZUmPfdh/o+JlefwwMRlG5rK0hXwnx8EHn7KcSxBHuG8Y3zoR/ayxkoyPjCjJuDi4Bs5Nbu8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tl0AS49R; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1362027f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759483847; x=1760088647; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBt9sQ3D35nPjr/0RJe6RkWlXbYt10tG/bFkTZQxvEs=;
        b=Tl0AS49RuMil2112GCILDBTccy4PdAEkp0aIIlAcukl+8DcBeFEUOl2Pw3cb+7nyGg
         6iLtxAdBgOUhYe5ts8T4N7HKdU4wC7s1BP1snIPJULJ0oSEXlc2lK0VEgkx+fyxi+zLt
         6hauQZsAs2RMTT7zhaYyZvuA1O7mqzexAMgrjkcOtfV0qUJE8o6d5F3Su39VpD7s8P76
         qgU+Sl2aOL0q5OAFkixN/9BEwBbuygjcN6fZAEyy5Kr2uPu68NMch7dQhZtLE/w+EljE
         gpDE9v9cRBeZpHaBedBGLd/no5sxkYPLj2uactpgay74bvo83WA6gWXJIT3P7ZC0+xnU
         jxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483847; x=1760088647;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBt9sQ3D35nPjr/0RJe6RkWlXbYt10tG/bFkTZQxvEs=;
        b=ClCpNb0UHRn4udZvi/EJVFnYqqsHDh/clxVueF2+aBvDnF3a4gifdbVMeD92uHcL9W
         tzKdtleX3YrtEgV1nwDkh/IkLr4cAyeEdsYXFpBE7DuL2tuzRY3M8pjeEdAJug9dMDTu
         XxNaduXEGLLeWYJsUa/uisr7tcXY2GxCNig7YDQRz2YgqN2vQ4mcrUSKARSTnEp4aCL6
         eY65EQKM35KhhYpFot9amoBerMjEqzDx/R7uUKDqs+6xPnVH8mUtBHsiVN+NsnOCrPMn
         JDMO5dYS+i+F/Ng1xz42aAORxhAYam4QDIBwI8bo7lFgr8gsFdYtuttOfHdZZKj4/ZdT
         J4WA==
X-Forwarded-Encrypted: i=1; AJvYcCWs9zyB0+kp266xB9Au5xZlc+aA3LKI1s2ZW+1N5WIxnjngp1dofBUxalQgiCrLKiNUJmQRsb1fx/nLa3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPqpkCe3+bzZZwaeP95uFj4U/7JtBPnl6vCREPV+Ip+WsdQH7O
	lP9NTlzvTQJopGntorcfLtlkzF21zqhjG2KoOqt437vZpIHe6zbsXn7ClFXWSSMUMNU=
X-Gm-Gg: ASbGncsvZIj7Mcr3bFL3vE7VzZ7y8K1u1ShXgIf5pdZCc6L2OX5FCeyzYvWxuVvd66p
	UMtBPda4JQEVKc7PtXFRNCauoVE58h+9301c5ug7Zyvv5puVWi0bPvRuCg6tWnzne6ovUetRUKa
	a3OXIatF7cprgmVawcwu9b0M9mWZnRtIod6HCioPq2CbrA4iydAMkS+GbOARoh7wlh6EqBOsxJa
	l6XH+c4TnUagfIdcmuYY0UKxU0emMhs2k74+0x2FLG7Jsm2AOc1usfToXI67vkCxFsRZUB6Dhpy
	3VN8QTkjE99ajXR4f5Q5ZvWxVFaJCnWHEAOL4W2zs+r978Dzp1NWnbt0CAzbJspPtIh4u2CwuyH
	0rWlaW1YVJAqyAkcGrFAQtSsZZopZC6Ru0X1q9SQZFwgIrjXcchrDHW3s
X-Google-Smtp-Source: AGHT+IEiUMPA8MqxUGgCJF3dzR9jrj4sZakAlaFbxrDTR/05ZU6XCC1uwI5Zc+1AT4pSlne8f2foMg==
X-Received: by 2002:a05:6000:2012:b0:3ed:f690:a390 with SMTP id ffacd0b85a97d-4256719e3c4mr1507845f8f.40.1759483846850;
        Fri, 03 Oct 2025 02:30:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8a6b77sm7143523f8f.6.2025.10.03.02.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:30:46 -0700 (PDT)
Date: Fri, 3 Oct 2025 12:30:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] hfs: fix potential use after free in
 hfs_correct_next_unused_CNID()
Message-ID: <aN-Xw8KnbSnuIcLk@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code calls hfs_bnode_put(node) which drops the refcount and then
dreferences "node" on the next line.  It's only safe to use "node"
when we're holding a reference so flip these two lines around.

Fixes: a06ec283e125 ("hfs: add logic of correcting a next unused CNID")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/hfs/catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index caebabb6642f..b80ba40e3877 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -322,9 +322,9 @@ int hfs_correct_next_unused_CNID(struct super_block *sb, u32 cnid)
 			}
 		}
 
+		node_id = node->prev;
 		hfs_bnode_put(node);
 
-		node_id = node->prev;
 	} while (node_id >= leaf_head);
 
 	return -ENOENT;
-- 
2.51.0


