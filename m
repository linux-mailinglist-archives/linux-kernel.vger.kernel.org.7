Return-Path: <linux-kernel+bounces-899047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A57FCC569EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCA70347B70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1136A333450;
	Thu, 13 Nov 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Az2qWpFU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rh62LanU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D73161A6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026487; cv=none; b=M5wZWlTQSEKP9ZW7kSgpSoCpNUGDS+CsUnFbchPIF2iCPPu0Lhc+RLY3MaIzmpnBvZyySeRe85rmNrYKuVtxbCkjmR4iUbMPeSVT5+OaJDAVtDJBydufHzwFp2auyvdb7W10DUMUfXLMObtwqlU0dvU6HqNFpOCpCROIFl/6KFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026487; c=relaxed/simple;
	bh=xfR1KLx+KNaQL4dbz8fvBPF4m749K6io0Z6FCilb3Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ5ufDkY+wRXpItXzosmizdOENOD5oBx/15PNdgU7oscZ9fQ/FMCDXfQZhpBGDxD7Yl0JhLVkHP+ac2M+2DVWoAXFpae9zYaSb2ABnfVjWeJA9GMSiX6ymFU+u86ddOEWdiuqPWo5y8S0SZ1wZJE78TRtv0z+b2LGLj8r+5Jal8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Az2qWpFU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rh62LanU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=63W4XiiwxwFoFYtLR/OQ3ZfVXapccbvLIf45BvuiCEM=;
	b=Az2qWpFUNVvO2RYDD8sR+hHlGt0DRT7urbRBdUkLax62NtDVg9gv3AaqkRaKiqfi3uYf65
	n2RNOiHZGMSH8FBHRXLKueBhLGFdhzybV6PksjL/flFlU1bGscgFPn8HcLQu0MIMcyYsWP
	jBZ2A0NCR0YAcr7gHubk+p0HowLNJWs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-OG6rtAcROUqtzfCdp4lhVA-1; Thu, 13 Nov 2025 04:34:42 -0500
X-MC-Unique: OG6rtAcROUqtzfCdp4lhVA-1
X-Mimecast-MFC-AGG-ID: OG6rtAcROUqtzfCdp4lhVA_1763026482
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4773e108333so3820085e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763026481; x=1763631281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=63W4XiiwxwFoFYtLR/OQ3ZfVXapccbvLIf45BvuiCEM=;
        b=Rh62LanUAvCfO9lGd3cEoZqWga6ZoaeSHE5F9QUcq3YzDvF+Z76thywc92yIvSsj1a
         hKUC9yJYtxbIuPehS1V8RDIk9l3wq3EnB0Lo+6yTxkK4VYRGjMVfdjOyfZVpmv+GB6N3
         acHAdzvi9mqbc3+EqedRPLg6JQ6CMXgXzgQ2VeCEvzYFSkuiHeDjFEwXEueAOAZMYIVH
         Hksoh60XhTB0I0Fl4u+wvNPENfzVe96L2e+HEqYlp0F0HZzNxHw+Pa8S5nazmXIuo9tv
         mg/Nhp0OZESKihSf1OkmT9FwH63x5fJuvVH210mDxiUusQJV4SRgIZE+XWOh25ZWTh/I
         mouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026481; x=1763631281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63W4XiiwxwFoFYtLR/OQ3ZfVXapccbvLIf45BvuiCEM=;
        b=K/dhhhnwsP7c38azqmj1n90VdwsRND7N60cUO36oYPG34Exgy6voAp2NPv1CQIBeHf
         5fNiuDuStVCL1Fg6cfL8pG4OiLvo6rNWGa7TO3PdJ6b2/McEKBF5gxPpRi90xYKm+tMx
         7pnTv7d2gPKFfUEUr777pjL3orJA/HidThQ8rL3JSwtzTESUK+l0VNZ/KduTmLoMiyYw
         JjDt8J+1VVyxuZLEeU/0nUFj3YcPzgHbVi+PKTgoVd+k+nU77a+8Nc8fvViz5ipUD0qf
         +vodjLUOtoaqa2hBXv/cKtZIfyK/Ar+nE5HMDgahj5I/TSrvSa9uB59YbFONXvB2o+4A
         GkAA==
X-Gm-Message-State: AOJu0Yxw5Z5IL/GHWKA95vAh5kNFzYf2XcX+xxGuG/XOG9mfrmfajfUj
	sMEZEoJPuvkj92lMyHDVgrVltHP2tPysbsezaTAMb8VoB5M+vzzUXjgznQnV3vlmXXGSBmzK4RD
	CblhM97xlVc/Gn5FdvEppZbyOZ02Mfe5Ff1fFLUB7JvQsEpW8ylRkDf2wA29iq0QzXumS0gp43R
	g+NXJ5NlBiEkxT32fk0f9dCx1LM1vN2WzbEhtTeFfxpo9aVA==
X-Gm-Gg: ASbGncu/hCHmnBgu8fRKwJyojTbxe2NlVQcXaZKo3lFU2r5rc7LnH94Jh3lQF4NAFef
	BcVaebi/y96L6IRJX4fbNZuW7bi29NVltHr/Hdb6i/JaUbIvMY9/BUA21lvs7VBD/436HCCS7rt
	0gT1y5xfXTiN24z645hqBNewdbQAzAAFy+v21t7oC1MnsjgrY5TlcvBXMe/XnGQJlEWHrZ06RHR
	I/RIRbu2Iipd5HUflb07EvSb4KGGujgbhxqh3PboduaEzA1aczH7rOI0ng6ZcpVgVL1T3y3hbXN
	IpfSOic+moiQ0WXbWvhUB2zdxiaV+MybaFuWUVZ+4Xga+VSU+I1d6k+TPoixC7bMl97Ip7IVqYq
	gUJcoMu4JIZbuvmtQbVA=
X-Received: by 2002:a05:600c:3b17:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-4778704d781mr55602385e9.15.1763026481335;
        Thu, 13 Nov 2025 01:34:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnyqEDIQmdib5/zX3gGR4BSqFJnDRLq0SIXwuP735KDm2HXcgCzc9KXTW9ExR3VdSFpKkrcw==
X-Received: by 2002:a05:600c:3b17:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-4778704d781mr55602015e9.15.1763026480857;
        Thu, 13 Nov 2025 01:34:40 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bd08bbasm16670505e9.2.2025.11.13.01.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:40 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 4/8] virtio: fix grammar in virtio_map_ops docs
Message-ID: <3f7bcae5a984f14b72e67e82572b110acb06fa7e.1763026134.git.mst@redhat.com>
References: <cover.1763026134.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763026134.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Fix grammar issues in the virtio_map_ops docs:
- missing article before "transport"
- "implements" -> "implement" to match subject

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 78cf4119f567..6660132258d4 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -141,8 +141,8 @@ struct virtio_config_ops {
 
 /**
  * struct virtio_map_ops - operations for mapping buffer for a virtio device
- * Note: For transport that has its own mapping logic it must
- * implements all of the operations
+ * Note: For a transport that has its own mapping logic it must
+ * implement all of the operations
  * @map_page: map a buffer to the device
  *      map: metadata for performing mapping
  *      page: the page that will be mapped by the device
-- 
MST


