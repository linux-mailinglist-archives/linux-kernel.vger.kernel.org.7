Return-Path: <linux-kernel+bounces-726927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C3DB012F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FFA764E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFBD1C84A1;
	Fri, 11 Jul 2025 05:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7+43k3t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E63208CA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752212758; cv=none; b=vCS+Q0hon1YgpzCC4MLIKNiFymTcztlFzXOiLi7BqgqFlSae/ECA/j0PTVkOLFdwZg20BEhi9zTTSdU5AwUu2hlyeIwWUbNX0EnFpFlqqIfSgNpToKQ0AnQXGpLMg1mwSuft9i8Jp3/mGUhf7eYmIzq8yJJOkBbaD/AEYXAM/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752212758; c=relaxed/simple;
	bh=hh2viuw6/CvRpR3oJ1xx03ZuIBGwZAIq26Z/R1oJzXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zx1Zjjc6bqw5xYidEl/rAT8T4P32t5Hn3nnQqqm/VTrJmTQfR3mg4zKy1vIc5hQmpAXs1vnyvtdjD3C066eOMdIx74MhxixucjgTz7+pIA9LckkUhJlENnTa5sRnnZKMqX+tYiJvWl5xo262Bg0RubjFi6F36qwmd2GPancwnro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7+43k3t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752212755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0qtyNVJKoY4vUM6H0HNH1aeGZFsWkPI7ERqDS6nK5Jk=;
	b=h7+43k3t6aTMArK7cv1wKKNYEqw4aTrXQxqidfAYihJHmvitc8s3WgdQjmajAp1myWMAa0
	J4amgjOLZjQqPAUN918RdmaAXditf0+joiipJON6pARKLYeApbwqjE2nPjibRfxo4UA0Cu
	LY918oblK3mjiJ0UiYzziSdvqtecQXA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-2u2-2BgzPRK2RpKllGoKuQ-1; Fri,
 11 Jul 2025 01:45:54 -0400
X-MC-Unique: 2u2-2BgzPRK2RpKllGoKuQ-1
X-Mimecast-MFC-AGG-ID: 2u2-2BgzPRK2RpKllGoKuQ_1752212753
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E40D419560A6;
	Fri, 11 Jul 2025 05:45:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 206751977000;
	Fri, 11 Jul 2025 05:45:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-spdx@vger.kernel.org
Subject: [PATCH] LICENSES: Replace the obsolete address of the FSF
Date: Fri, 11 Jul 2025 07:45:48 +0200
Message-ID: <20250711054548.195276-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Thomas Huth <thuth@redhat.com>

The FSF does not reside in the Franklin street anymore. Let's update
the address with the link to their website, as suggested in the latest
revisions of their licenses.
(See https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt for example)

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 LICENSES/deprecated/GPL-1.0 |  6 +++---
 LICENSES/preferred/GPL-2.0  | 10 ++++------
 LICENSES/preferred/LGPL-2.0 |  5 ++---
 LICENSES/preferred/LGPL-2.1 |  8 ++++----
 4 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/LICENSES/deprecated/GPL-1.0 b/LICENSES/deprecated/GPL-1.0
index 3a4fa969e4c29..8d0a75431f06d 100644
--- a/LICENSES/deprecated/GPL-1.0
+++ b/LICENSES/deprecated/GPL-1.0
@@ -14,7 +14,8 @@ License-Text:
 	     Version 1, February 1989
 
  Copyright (C) 1989 Free Software Foundation, Inc.
-                    675 Mass Ave, Cambridge, MA 02139, USA
+                    <https://fsf.org/>
+
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -227,8 +228,7 @@ the exclusion of warranty; and each file should have at least the
     GNU General Public License for more details.
 
     You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    along with this program; if not, see <https://www.gnu.org/licenses/>.
 
 Also add information on how to contact you by electronic and paper mail.
 
diff --git a/LICENSES/preferred/GPL-2.0 b/LICENSES/preferred/GPL-2.0
index ff0812fd89cc4..ea8e93dc44bc4 100644
--- a/LICENSES/preferred/GPL-2.0
+++ b/LICENSES/preferred/GPL-2.0
@@ -20,8 +20,8 @@ License-Text:
 		    GNU GENERAL PUBLIC LICENSE
 		       Version 2, June 1991
 
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.
-                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
+ <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -322,10 +322,8 @@ the "copyright" line and a pointer to where the full notice is found.
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
 
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-
+    You should have received a copy of the GNU General Public License along
+    with this program; if not, see <https://www.gnu.org/licenses/>.
 
 Also add information on how to contact you by electronic and paper mail.
 
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
 
diff --git a/LICENSES/preferred/LGPL-2.1 b/LICENSES/preferred/LGPL-2.1
index b73f9b6230f52..105b9f3c5ba12 100644
--- a/LICENSES/preferred/LGPL-2.1
+++ b/LICENSES/preferred/LGPL-2.1
@@ -18,7 +18,7 @@ GNU LESSER GENERAL PUBLIC LICENSE
 Version 2.1, February 1999
 
 Copyright (C) 1991, 1999 Free Software Foundation, Inc.
-51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+<https://fsf.org/>
 
 Everyone is permitted to copy and distribute verbatim copies of this
 license document, but changing it is not allowed.
@@ -488,9 +488,9 @@ FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
 for more details.
 
 You should have received a copy of the GNU Lesser General Public License
-along with this library; if not, write to the Free Software Foundation,
-Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA Also add
-information on how to contact you by electronic and paper mail.
+along with this library; if not, see <https://www.gnu.org/licenses/>.
+
+Also add information on how to contact you by electronic and paper mail.
 
 You should also get your employer (if you work as a programmer) or your
 school, if any, to sign a "copyright disclaimer" for the library, if
-- 
2.50.0


