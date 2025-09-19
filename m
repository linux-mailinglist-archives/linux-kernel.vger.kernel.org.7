Return-Path: <linux-kernel+bounces-824159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3B7B883E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EEC4E10F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F172C325D;
	Fri, 19 Sep 2025 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYZ0JrL2"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA662C234F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267854; cv=none; b=a7jqJCojGUrrFvOmrHOQVBhTHnluKSr/rMpb0lPl8Q17YPzPoHgejG7+eY7hefwktZMpu54KeAa+9CseSPmJ/I7OC5o+L4o8cBwZVt66CSVtUTB8dKDEmPrAZOOSYWARSBGR6kZBD9zlv2UBwikYxIpsakB47NJ+52ItUsjAU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267854; c=relaxed/simple;
	bh=047gxH9Ln/Nh4q1TaIByviHoFLLL6DAEUP/a6yDoQBA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jEKUUYy8TMksigA9104RvY+c4teOjtSFFIRFp29Y7FzbVA5n225D5iATLb7HvbjZvifFAdsyDkJCCO+VV//IIwoI4v4rWjhIdHJF1nS9Efw4dE7hdCFFvU8SVSIY4pkHrXfUsvKI8bvPmkNdPBzfc1gogCrfDDBPbk8+Oa1gWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYZ0JrL2; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b04a8ae1409so169620966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758267851; x=1758872651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7PgYC9jmyfrCZbvdyfHm60Addy+L150lAxZLyQ7EXQ=;
        b=SYZ0JrL2Cy8FtBKpG9+W0NK6R88eewzRWp7xKE1uRgtk1wU7ldXdkNic0xj4YLZYZM
         zGLyWC33sRWCA1kkT6bb5i770vVWpcUwK3nnw37tv+LhYkAHp9EgBK/AOeMIYImBifvF
         KcNVQX2LmsJBVN3PzvOzu/tmpZxoz2piejXGq47CpIiowWNV9nkg6krtCPGD2GhHjncZ
         PK/thkn1G930sNtoKo2MoXnbVVlVVXRRbctYp9Gg24Qm2z+VMyWpfBnmEE5tlQOh1Roc
         OshW68r7K/ty6UvkWz5BL8wsxAINNzESWFwDFRwiOwKNcManBNbFNexZo3i3oUl2FadO
         2dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267851; x=1758872651;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7PgYC9jmyfrCZbvdyfHm60Addy+L150lAxZLyQ7EXQ=;
        b=rIbSiz1RRVzfYmGrVIv73WSZpaeyr4cBjK/TYylZziXXgqa3PVIrqJL3OzkYntwk4s
         pT8Ml3QqMNV2ao1UMlVbHOBZ0LGynBwUw7QAEiT7z7pNt7oMcVnvaTNXHTURyVqdBJRo
         Q4gg3yahATDrWdvLxHy89To62lI4gwwkNm1Wig1cF8CRDiCvYYP/+kbD2N2ZJoW8/njN
         phABefGtFLZeBS/zknefTACupd2fG8XNeqELOoK9OFagbkOV/MGQs3qnA/wMC2tTakQD
         YFzQM+bzgvVM0NLXryEXL0jb2Dc8Ex19qnZXcwqVJd6/3SKyKyvR7phgbv2iq2UZk86u
         2Y3g==
X-Forwarded-Encrypted: i=1; AJvYcCXcg8g+WM20GcW94VSDTfIC8K2eJccNHuNL4JDHdUNwkBAmHcSf05opPaG0/QStEUnWUY+x1ar7Zcr1AIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykF979TkbUBp8S1mv5SjAODOVVGXyemh+zu0jMh3WU0crlWGlo
	tzBgpSbqq/XKg80Ex9uvDh0pVX6UKQFf+/hxWEkBiGtMcbiuHxGrm/GXybHZton41NFAMLUMebl
	+frCLUe9BIg==
X-Google-Smtp-Source: AGHT+IHgY7aJWWyQMnzXevoWxP2gnJgXATXyRzyJl6hO+lIdu02UdQfQvHFWeVcH0R9ftY6JK21TYjjEYS9Y
X-Received: from ejcfj10.prod.google.com ([2002:a17:906:9c8a:b0:b23:3ca4:c982])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:794c:b0:b04:5b3d:c305
 with SMTP id a640c23a62f3a-b24ef9721cdmr270071166b.17.1758267851262; Fri, 19
 Sep 2025 00:44:11 -0700 (PDT)
Date: Fri, 19 Sep 2025 07:44:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919074408.868220-1-abarnas@google.com>
Subject: [PATCH] drivers: mhi: make mhi_ep_bus_type const
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Manivannan Sadhasivam <mani@kernel.org>, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Akhil Vinod <akhil.vinod@oss.qualcomm.com>, 
	Sumit Kumar <sumit.kumar@oss.qualcomm.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because driver core can properly handle constant struct bus_type,
move the mhi_ep_bus_type to be a constant structure as well, placing it
into read-only memory which can not be modified at runtime.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 drivers/bus/mhi/ep/internal.h | 2 +-
 drivers/bus/mhi/ep/main.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index 577965f95fda..512da7482acc 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -11,7 +11,7 @@
=20
 #include "../common.h"
=20
-extern struct bus_type mhi_ep_bus_type;
+extern const struct bus_type mhi_ep_bus_type;
=20
 #define MHI_REG_OFFSET				0x100
 #define BHI_REG_OFFSET				0x200
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index cdea24e92919..86e003bc44e0 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1703,7 +1703,7 @@ static int mhi_ep_match(struct device *dev, const str=
uct device_driver *drv)
 	return 0;
 };
=20
-struct bus_type mhi_ep_bus_type =3D {
+const struct bus_type mhi_ep_bus_type =3D {
 	.name =3D "mhi_ep",
 	.dev_name =3D "mhi_ep",
 	.match =3D mhi_ep_match,
--=20
2.51.0.534.gc79095c0ca-goog


