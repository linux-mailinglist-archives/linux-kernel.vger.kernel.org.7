Return-Path: <linux-kernel+bounces-739053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F40BB0C116
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F05188BBD8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A5C28DF3B;
	Mon, 21 Jul 2025 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecOokqJd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310028DEF8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092954; cv=none; b=PXmBviDXuFB0atzCrb2btDNzZlwfcGjMqYazhl3/3Io/rEmwm0o6tIBpK11y7ngDbcqEH8l8CD7cdvUKX8GIpTtYw2anOSFPKC6tSWFT7BqmdKNdhvc4WpFGTCpLRxonjS2mFjQUktSOR6VwqYcmOO+vFR5CNgEomAmPE64VkjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092954; c=relaxed/simple;
	bh=yaHhUQG9fZNfr7pAgNtY5q2S061vd6ciz8mHZO0cGzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDhywnUzdUvLr5aFPNBxwlwxekxM/kxPXVWy8GcjXF6TiadaHNMU6P2a9xJZuCcDAQPsf2w5/071LDx22XssBg2Ja0K6j6IsVK4zZbR/k9+wYgqRW0171njX/gMa+mDvg/2WLeiKzychcvOtqKot17ugShGfzrjCcJqxPaN+5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecOokqJd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753092952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GI8hof1UmsMFGgxy7NGXL6mMlN9cWMdfaEiozubOAZM=;
	b=ecOokqJdBR0B7yvcu3NLw+dTjPkHpNFwFF1h3Y+itV6I+P2lauXyQrFZ9SQ9C1zolGVu0A
	vOBzyxqnHN0lKSIpM2vu66I9AqniFmhrGlvriUGOk6T3/MbnaE0PtlNYBJWseThHTltblA
	3Tw9EfdTiU7OLkB9AlevKb32b2/MjlA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-Nf-9jgZoO0-pugUCmjQwOw-1; Mon,
 21 Jul 2025 06:15:50 -0400
X-MC-Unique: Nf-9jgZoO0-pugUCmjQwOw-1
X-Mimecast-MFC-AGG-ID: Nf-9jgZoO0-pugUCmjQwOw_1753092949
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72E6918001F7;
	Mon, 21 Jul 2025 10:15:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61E3918016F9;
	Mon, 21 Jul 2025 10:15:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-spdx@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] LICENSES: Replace the obsolete address of the FSF in the LGPL-2.0
Date: Mon, 21 Jul 2025 12:15:34 +0200
Message-ID: <20250721101537.276552-4-thuth@redhat.com>
In-Reply-To: <20250721101537.276552-1-thuth@redhat.com>
References: <20250721101537.276552-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Thomas Huth <thuth@redhat.com>

The FSF does not reside in the Franklin street anymore. Let's update
the address with the link to their website, as suggested in the latest
revisions of their LGPL-2.0 license:
https://www.gnu.org/licenses/old-licenses/lgpl-2.0.txt

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 LICENSES/preferred/LGPL-2.0 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/LICENSES/preferred/LGPL-2.0 b/LICENSES/preferred/LGPL-2.0
index 957d798fe0372..dc629746eb726 100644
--- a/LICENSES/preferred/LGPL-2.0
+++ b/LICENSES/preferred/LGPL-2.0
@@ -16,7 +16,7 @@ GNU LIBRARY GENERAL PUBLIC LICENSE
 Version 2, June 1991
 
 Copyright (C) 1991 Free Software Foundation, Inc.
-51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
+<https://fsf.org/>
 
 Everyone is permitted to copy and distribute verbatim copies of this
 license document, but changing it is not allowed.
@@ -468,8 +468,7 @@ FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public
 License for more details.
 
 You should have received a copy of the GNU Library General Public License
-along with this library; if not, write to the Free Software Foundation,
-Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
+along with this library; if not, see <https://www.gnu.org/licenses/>.
 
 Also add information on how to contact you by electronic and paper mail.
 
-- 
2.50.0


