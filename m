Return-Path: <linux-kernel+bounces-835266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F34BA69F1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60AB3BB2AB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12724635E;
	Sun, 28 Sep 2025 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c+4q2nWB"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689231DE2C2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044419; cv=none; b=g2ythGGR+sdoc3LryR1c0LJPPglGXL8B59TeGoF2j56lffaVZq9+IMMKQ2Uc9aO55FascAPYr+0DPgaz9pvBQDv6JcqXNEr7/spnETWM+Q3kBRR8O/ui3qCXJsElHhvrgrcVkrXrAm0glEVMoyOXo6At89wDB/Xju3FKgzHkNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044419; c=relaxed/simple;
	bh=/SdbOeTbQpmJeBG/7uKnsxaZCMB9be//TsCeMES2BBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VYhfk7qXOkAkA9YhGXHQguCnI9cZRJMu3pA5jqjwK2EYP4/+W9NoaIsOQyvkzKy/5msl5KQ6PN4Y1ZqrWB/AMDCvZtN4cEulsiOMPXU9NkgcARscvYh8YYGRGxFmGv0VPm9smixY+ZSVCK7xM5+dCwKNdqTUWtq5jhWTeuHDgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c+4q2nWB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26e68904f0eso35782375ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759044416; x=1759649216; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UAaSdOVkV1NKdeMiOYB6QGMYFLsTHfIsFJ3zeJzXSPE=;
        b=c+4q2nWBdHPmQD3+HPuO9PvmpCzGVD4iNRZ0rClxV3qknbiCZT6DrkfiWGexy4rtQn
         GCE0w5LAOC6k8VsizDj/doQ4jm50YB1MnNeywS4lSA76iOiI42bAlP5ZbOtcQrwE950R
         l2+Qx0NIRPzd7a3eMFMZHv7Fa+cZNuvwnY4zLpzdaLm9fSlGrIQ2w67cU8KKEGtipZBQ
         rTQ6KpYKrVZVODFfNtgaLH22cOI7KLY1cMvW6jXJpzhmZpfwRDaK8Mbzwryda/Y7tVVO
         /dy42FZ6eBd4LL3YAjmuAuYHZ4PaOMEF/3xgJMabZifBomr4ETnfWKiykUsTZBarMbWl
         C8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759044416; x=1759649216;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAaSdOVkV1NKdeMiOYB6QGMYFLsTHfIsFJ3zeJzXSPE=;
        b=FODNDsUMyQyi3EGLSE4UzulEqn4RfmxoowmFPN4AEg4SNU7EZDXOPuKBm1rOEZnWAD
         dNW8fUV6l9TpkYw0o8KiulabfeNHfemx9whYdfwKPOLtzoTv45MrUZbH0uQwkEwAEhTy
         +7zm676SSMwIrfXGtQo78v1L26utDnZZ8sEq+96Z3AQh2NYUyP6GRkdvpHkiRqpwfRac
         QqHtiwkw5NmkHGN+qqaTpibIWHRhsaom9d1gSzZlGDBBJJw7y5wxxdAFV4LfzLvYnHZu
         fuGTMqp0AwB/FKMYvp7O1kablJyu472laojGTdTeQxS1Tk+rZSJe+YTN/Pyw4e66DsD/
         D6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWz171xkeFyK/WgLDYkeaI+khreqR1FcgEZNQ8hdpPJ9VOhN2d7a1LIDtovYvh1jzMie1DozIu11PFLuDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7V4hUelghZpIt6ypxbjvw7cz5qT+eteU9vDmtscRNn0ydbyVK
	m6vRyu5e91ZIhgEWysnq3rFWzXEXTZ7NtT6L3WKZbTV9GiGepl2fj/fDudhBNShjWaq8u1qsLaV
	Vh7sxkSwR5coY
X-Gm-Gg: ASbGncvuRzXx8twqPwNYjVn2W3S2TDPJFcdemcc2Emc5XjDKwARA41bGdVMjnLzEG98
	H2sJZUz7npbfYOT8LjfV88U4WW2LHiTmcCtdTkFnvoRkstIhwc+N/BVvCFwnm2FBMfkwb9/2l+i
	+U7zfswtIcBtU36BbcNpXEWp7cDBt5NwOxn6tBNFUayzUe5FOJ+H4En1/IxsmlYzN8VTMzf+Buq
	52h/CKtS5fIire7bPU1NSbRagHbmgCk/38cPAyhg3q0HTv8MNSd939HFZQkPkRhcQzAuAOhkTTC
	KWWjMyzzEu6yivLHMVj8TFlOyd29tc9rmyEOYbRBAehTNsh66KyOxc3kA57TX5QTHYYGllzUmWC
	h8oOFQ0KQioh4fjxA80oGsT+F9vl2oty+huQnMZJ+EjGnuT9IaNAUpeAI0XwdbsExyO4=
X-Google-Smtp-Source: AGHT+IFHxe1rBHtIpqSjLfdUIUmkMST8JmIBra2PbaznOWAXLh3kC1g/w85xIIVUn0jBe/mif/ikOQ==
X-Received: by 2002:a17:903:17cc:b0:275:3ff9:ab89 with SMTP id d9443c01a7336-27ed4a319a1mr130543335ad.27.1759044416495;
        Sun, 28 Sep 2025 00:26:56 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d32dasm98492675ad.27.2025.09.28.00.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 00:26:55 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Enable PCIe ACS once AMD IOMMU initialization succeeds
Date: Sun, 28 Sep 2025 15:26:50 +0800
Message-Id: <20250928072650.1419-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250928065817.1279-1-guojinhui.liam@bytedance.com>
References: <20250928065817.1279-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Date: Sun, 28 Sep 2025 14:58:17 +0800, Jinhui Guo wrote:
>@@ -3212,9 +3212,6 @@ static bool __init detect_ivrs(void)
> 	}
> 
>out:
>-	/* Make sure ACS will be enabled during PCI probe */
>-	pci_request_acs();
>-
>	return true;
>}
> 
>@@ -3284,6 +3281,10 @@ static int __init state_next(void)
> 			ret = -EINVAL;
> 		} else {
> 			ret = early_amd_iommu_init();
>+			if (!ret) {
>+				/* Make sure ACS will be enabled during PCI probe */
>+				pci_request_acs();
>+			}
> 			init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
> 		}
> 		break;

Please discard this patch. It breaks when interrupt remapping is off.

