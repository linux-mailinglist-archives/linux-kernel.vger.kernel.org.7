Return-Path: <linux-kernel+bounces-863202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B6ABF73B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883053ADE70
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49113431FF;
	Tue, 21 Oct 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC5ZNzoC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA42341ABF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058866; cv=none; b=NSisWiyvUC7tqYLIiZJiaqXk93cWg1+X8JADgXzQlp0vsIWc94UWWynvbIMC1P0KdZJR1shgNIJRhSnIxBrxBvSl4zDl5ZM+z4de0dJkRnXy/ARiRrO5rAd7RdF3f8NEy3E/EoX4u+13azVvTckr8ePK26SZach3nxjXKk1raKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058866; c=relaxed/simple;
	bh=ulLWxUh8EsRrOFrJv2gdzbq5iaYJxZBYyWiTN0ivhT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxa+behz6MX+awIz+TZBubikF2tT/dth/7slSeA35EY6HrDhIlQI6/xdWsUwG108Hg8BsSMgx+/InWlZPtQi2PuaVoBlAWA4iQ34VXjuvbst9VXKWp4FKnaJURMcRbOw9IiNLvouxe8hnvqslq6Qj97NbZqyOljtuNFNE1ATNuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC5ZNzoC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRubUKoIKZa05nEVw7UJ7l9fUFkh873Slwn5354MkBU=;
	b=DC5ZNzoCloaM4gJybh2QuRzDO6C6sBdas1D49js/VQ8qVWMfn0KStHyp3B5wH+t5c1LUb5
	B8Bjs+URrI5LSaLiVhB2FNZ4PDqWC9qsBUwncS/fcfhTkkFBa5BuwmTa9tEn8z87PZKIDm
	Ux62NLDnYV2GkNgljduZSwVw73d5Dd8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-flGlgBHSMFmVyQ0Lan-uQg-1; Tue, 21 Oct 2025 11:00:58 -0400
X-MC-Unique: flGlgBHSMFmVyQ0Lan-uQg-1
X-Mimecast-MFC-AGG-ID: flGlgBHSMFmVyQ0Lan-uQg_1761058858
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4270848ceffso5759683f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058857; x=1761663657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRubUKoIKZa05nEVw7UJ7l9fUFkh873Slwn5354MkBU=;
        b=srUwLn4TVy6PY5kMgTjJenfi1IkZHL0JDZQy0dEnRj3hrFZ8158w3vlVlpzPVsc5DC
         uYQ4c2xpFU1nvHhBlT3QcXFesfwfktPCDMicZBbNxaZ5r1kPqFX2LqAU3IuXZ1vwk6wS
         fEAja5Gf5u9k8UnMd3hlxcRNuZvL63woIVOrPu+U70sWRIsRQ+eoZUSLWGwtDCHu/Ypl
         0QezTmlKTFspzCJ2fMmmMdk2S+qye5TX1kzDIDiqRgXHpb+M7rW9yQ26JdsSFtgmQTzG
         SREoonnw7CT6DCmSwJpSC7rJMbj3yHhrnRwau5nXSw6Jm6cipWsf2ODlEEMGjoWF04CZ
         mh2w==
X-Gm-Message-State: AOJu0YyAtUydfoPwLyFQi252kl3eVXkcDiZAX5hoo54qrRMNk2F2wHyz
	VA6jqUxf7bdQ0vvQkG9pq9q2EpAk3a6Wrj5fRYCShCJoEOiqtzVlCzQSNblh3ore+KvEnJmbPBR
	ZrzAK/nMbINyko97xf3QlTabTxZr/s1Wm3EgAv7lSd34xfJyFyIRtsMb3qcRKnYlH9iM0UMSpo6
	T2vR5YJT2y1XIoyB8tNe0LCwufl7L6vi/7mhEACbZj1BzWaA==
X-Gm-Gg: ASbGncuvtRv6P2uYhI3rhrxB5BOxGDoSFuobDlaa7sO+DzWlyoZ+or+sW15uI75paWL
	l0HtVuVsIbD7zNSMnQ8HlPtGMJVBlk9w08B8ivderqSTgmRxooT5caj2d3a+tGU50+CQLsfwTLM
	vMkldd4oqUIn2STrRyw4MS42P2oNVlFHiosvQo8+bazhD/g2P10qxca5gYlN9YAcjamDnqJWpcL
	V4znfwMxC85afjMQrSRDLvpj2o4oOTb5LZgH0v6o2i9oM8eqYqpJIl86hgw1WCZTWuHYmrp4x8i
	EWla86z7sSX2LqvM2rRVfhs1FxQh8be0QPYhZuhOUjkb1d3h39SVorCni4/M+C/zlQjPb4WJ5tq
	/LOF/p2A5Ls4r4Y4VsqEMUTjGwXXiLP7HCD0VE4WiAwOQg2OfZ8HI/n8DwddY
X-Received: by 2002:a5d:5d05:0:b0:427:809:eff5 with SMTP id ffacd0b85a97d-4270809f252mr11795607f8f.53.1761058857530;
        Tue, 21 Oct 2025 08:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuNdQq7IEo7xmxPaMqWMcC8QeroaNoRnXCBpBegLE0FB0KNfhJhInOomIlaVikmeTIuzyODg==
X-Received: by 2002:a5d:5d05:0:b0:427:809:eff5 with SMTP id ffacd0b85a97d-4270809f252mr11795534f8f.53.1761058856848;
        Tue, 21 Oct 2025 08:00:56 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f009a78csm20793541f8f.26.2025.10.21.08.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:00:56 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 23/23] MAINTAINERS: move memory balloon infrastructure to "MEMORY MANAGEMENT - BALLOON"
Date: Tue, 21 Oct 2025 17:00:40 +0200
Message-ID: <20251021150040.498160-7-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021150040.498160-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021150040.498160-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nowadays, there is nothing virtio-balloon special anymore about these
files, the basic infrastructure is used by multiple memory balloon
drivers.

For now we'll route it through Andrew's tree, maybe in some future it
makes sense to route this through a separate tree.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 878e53d0f65ed..17fbf5c1ea2fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16225,6 +16225,16 @@ T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
 F:	mm/
 F:	tools/mm/
 
+MEMORY MANAGEMENT - BALLOON
+M:	Andrew Morton <akpm@linux-foundation.org>
+M:	David Hildenbrand <david@redhat.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	include/linux/balloon.h
+F:	mm/balloon.c
+
 MEMORY MANAGEMENT - CORE
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	David Hildenbrand <david@redhat.com>
@@ -27062,9 +27072,7 @@ M:	David Hildenbrand <david@redhat.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/virtio/virtio_balloon.c
-F:	include/linux/balloon.h
 F:	include/uapi/linux/virtio_balloon.h
-F:	mm/balloon.c
 
 VIRTIO BLOCK AND SCSI DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-- 
2.51.0


