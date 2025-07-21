Return-Path: <linux-kernel+bounces-739052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210FCB0C115
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A183A54D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972A728B7FD;
	Mon, 21 Jul 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQzHZUSA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7728DB63
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092954; cv=none; b=ZgkVuq0rHXlxT55bXsJvvqlHVcNpIlmEN4LbaBdGa2caVv8jbT9Jv+XuDw+kNnvJ/3N+5exCMA09hZunKU3NIzzxF0QfMqqGnxWnt/GHZOktOMjVFlwSBFzEkSvhv472c9o6hqAkZXgf5AKIn9jWKMC0M330QqkZff08Hgk7rHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092954; c=relaxed/simple;
	bh=S9owtAt1UqdxSwzjhxbjY5sGLg2M1nO59dc7r2AMM1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+dYT8UgtcyFtugHhxDS3K2Qdt9hzYGEQjs/XcJb/h8PaM+xZ1LnZgtAeWEVme7LZSU8lZZIIUqOFcLVgyzciEiFqKgjKg8tvi73e7GowG+RhF3yz4E1e0mG26Qyf+M37tntmniTw+DWnzoL2Cqls95xVl9Je4XJobJRjK9aIyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQzHZUSA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753092951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdalZgA7tdwwim35dDzo53ryeCEhMe8Zi3jZpXTgcxo=;
	b=WQzHZUSAbBQ8zEYG9LOcGHUuUomd+HMZV1acprmhZd9tZTS4BttyFF+DM6QoSN6kG1wr7U
	MR2Pjc8SM3YzYEl/zwOLAlnj/GRBIu6PW8uBNfaCBXDaoC2NYcc5FyoaYE6avk/XWbu0O+
	GpvmnJgDHvmuQ7sljEO9XYfK5ccRMFI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-j7RknbwSMhiovRBP6mxpRw-1; Mon,
 21 Jul 2025 06:15:47 -0400
X-MC-Unique: j7RknbwSMhiovRBP6mxpRw-1
X-Mimecast-MFC-AGG-ID: j7RknbwSMhiovRBP6mxpRw_1753092947
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA43F1956080;
	Mon, 21 Jul 2025 10:15:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADF661800D82;
	Mon, 21 Jul 2025 10:15:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-spdx@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] LICENSES: Replace the obsolete address of the FSF in the GPL-2.0
Date: Mon, 21 Jul 2025 12:15:33 +0200
Message-ID: <20250721101537.276552-3-thuth@redhat.com>
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
revisions of their GPL-2.0 license:
https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 LICENSES/preferred/GPL-2.0 | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

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
 
-- 
2.50.0


