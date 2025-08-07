Return-Path: <linux-kernel+bounces-759538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D23B1DEC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C064C584C70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E762750ED;
	Thu,  7 Aug 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="QHlskJv0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1326E17D;
	Thu,  7 Aug 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601420; cv=none; b=q0XUjerODnPsnLy+0F73bToMRoFGAsCaIBFjmg71D/x/m7VlItOFiKI6dBPSwH+lui1sBjF+TSJpZUVWS7Vc6ICrSNyj8r3wnjBV6tGug8erlgoNBuUloGGbo7Xq07ea0aqnOitMiQ0Qwq85Vg5kC9jgp3d8lo6PiXXnxRYGHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601420; c=relaxed/simple;
	bh=KqRBDuRd56N3m9KxKv3azQILGxVKC/1No6Zj5aBTqro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+q6tcIQDmIgwc+elqCFYAdKlLFzarcg66CCqSg6CTBtDCpoEHGep/qxNnZ+W6jZCrTdvXBHQVUp/edZrzn28E1K7nIV1s5ghrFvvg/FLcpEz2yUYyw6JVawhpAfHHbX05+2EqL4+l4whRA1gnTvdB8jXOhmXT4wThubWkzw2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=QHlskJv0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8F48740AF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601414; bh=tAb0bk4ax5qVarJrbCOpaj+1ZBbHDgd+H5S0UrhGMBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHlskJv0XQXyzagwfoEXnuA8pot9zs/3iaFHj4iQkErHyu/yNaaed4ZdJfGe2Voxl
	 Cg+vU24IE7F40npOBpnLaOl4+cOOjL6AIoxTlzqkrVeRILaBuQNR1it/flL1i6MS0N
	 2DkbAq1uJaYteiLh0+L3Rldtf8PfapMmg116j5iONV/8R9TeC9N6z+LJtxI+rH5P/3
	 WQL56x6FP+8gOmXRE/6k925aePhIbb8bVetMvMDBTo6eoEpdeTyCrCpKEQguwowppe
	 N7bgbJFLpRW7QS4UvSusaO+FZQVScpFGq+tHPHnbtFPd1kR/h0Zt0VMCM+DZtTwsfq
	 THL3N4ecYkZcQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 8F48740AF2;
	Thu,  7 Aug 2025 21:16:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 10/12] docs: kdoc: further rewrite_struct_members() cleanup
Date: Thu,  7 Aug 2025 15:16:37 -0600
Message-ID: <20250807211639.47286-11-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807211639.47286-1-corbet@lwn.net>
References: <20250807211639.47286-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of some redundant checks, and generally tighten up the code; no
logical change.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 86 ++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index e3d0270b1a19..b3f937901037 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -673,73 +673,69 @@ class KernelDoc:
         while tuples:
             for t in tuples:
                 newmember = ""
-                maintype = t[0]
-                s_ids = t[5]
-                content = t[3]
-
-                oldmember = "".join(t)
-
-                for s_id in s_ids.split(','):
+                oldmember = "".join(t) # Reconstruct the original formatting
+                dtype, name, lbr, content, rbr, rest, semi = t
+                #
+                # Pass through each field name, normalizing the form and formatting.
+                #
+                for s_id in rest.split(','):
                     s_id = s_id.strip()
-
-                    newmember += f"{maintype} {s_id}; "
+                    newmember += f"{dtype} {s_id}; "
+                    #
+                    # Remove bitfield/array/pointer info, getting the bare name.
+                    #
                     s_id = KernRe(r'[:\[].*').sub('', s_id)
                     s_id = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', s_id)
-
+                    #
+                    # Pass through the members of this inner structure/union.
+                    #
                     for arg in content.split(';'):
                         arg = arg.strip()
-
-                        if not arg:
-                            continue
-
+                        #
+                        # Look for (type)(*name)(args) - pointer to function
+                        #
                         r = KernRe(r'^([^\(]+\(\*?\s*)([\w.]*)(\s*\).*)')
                         if r.match(arg):
+                            dtype, name, extra = r.group(1), r.group(2), r.group(3)
                             # Pointer-to-function
-                            dtype = r.group(1)
-                            name = r.group(2)
-                            extra = r.group(3)
-
-                            if not name:
-                                continue
-
                             if not s_id:
                                 # Anonymous struct/union
                                 newmember += f"{dtype}{name}{extra}; "
                             else:
                                 newmember += f"{dtype}{s_id}.{name}{extra}; "
-
+                        #
+                        # Otherwise a non-function member.
+                        #
                         else:
-                            # Handle bitmaps
+                            #
+                            # Remove bitmap and array portions and spaces around commas
+                            #
                             arg = KernRe(r':\s*\d+\s*').sub('', arg)
-
-                            # Handle arrays
                             arg = KernRe(r'\[.*\]').sub('', arg)
-
-                            # Handle multiple IDs
                             arg = KernRe(r'\s*,\s*').sub(',', arg)
-
+                            #
+                            # Look for a normal decl - "type name[,name...]"
+                            #
                             r = KernRe(r'(.*)\s+([\S+,]+)')
-
                             if r.search(arg):
-                                dtype = r.group(1)
-                                names = r.group(2)
+                                for name in r.group(2).split(','):
+                                    name = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', name)
+                                    if not s_id:
+                                        # Anonymous struct/union
+                                        newmember += f"{r.group(1)} {name}; "
+                                    else:
+                                        newmember += f"{r.group(1)} {s_id}.{name}; "
                             else:
                                 newmember += f"{arg}; "
-                                continue
-
-                            for name in names.split(','):
-                                name = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', name).strip()
-
-                                if not name:
-                                    continue
-
-                                if not s_id:
-                                    # Anonymous struct/union
-                                    newmember += f"{dtype} {name}; "
-                                else:
-                                    newmember += f"{dtype} {s_id}.{name}; "
-
+                #
+                # At the end of the s_id loop, replace the original declaration with
+                # the munged version.
+                #
                 members = members.replace(oldmember, newmember)
+            #
+            # End of the tuple loop - search again and see if there are outer members
+            # that now turn up.
+            #
             tuples = struct_members.findall(members)
         return members
 
-- 
2.50.1


