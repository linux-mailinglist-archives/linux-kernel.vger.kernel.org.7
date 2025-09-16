Return-Path: <linux-kernel+bounces-818221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A4EB58E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D078832252A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB62C3257;
	Tue, 16 Sep 2025 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c8tCVTSS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rz0qvUIy"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBD190477
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003553; cv=none; b=lCcrMvYi8+obQ0tL1aOGH34IzX7kHCDbDJ3YULXYCqmGqwirX3pq7VbwjitFJUSf1G3Fl2zsnNnJ+g1q+a8UsauN+dsbJNYBK7zBfjKi619TClY4ZQcqBProesiniS6tBypRej1tKgChu2WcKbyM4iQWCsFCnGRtoBDQ4Q0jsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003553; c=relaxed/simple;
	bh=OLuaaraOsWlg2xGbry+wtyANAtXvxZrhQxxn7u/wLAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRFTxxDJzT1JEFzqERh7UB7aXEOFLOolUk+JUTIV4VNjXsUB8TUzDnDnPPwKHv3+DK/g9sEYQxvR0cCbPN6+UzTDm5aQC7OqrFyqVexoJvVRMGSpDUYOJgtlLnhyJ7EyTPPfBC63JOFhKslaVWLYy1r7vE0eLbmwkQfAnHSo96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c8tCVTSS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rz0qvUIy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EAFF822603;
	Tue, 16 Sep 2025 06:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758003550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7O6H4yncJtI6jRPxDIzl6fb1efR8GujWZKD7CmF704s=;
	b=c8tCVTSSzRZCrEUhqi2pqQ231hFrThJXU+n1WJ676Eer9O+DPXRjj5D2e4Be0BN04zLHCf
	8P63lmit8RtcMGI5lR8wjbikazo6fDhfqAXRd8RVRWJvMfkUukZKCw3QDQ0bJ2urD0ZnFH
	uPSQ1TycJVS5khhSEtnO14qI5Fl4kFs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758003549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7O6H4yncJtI6jRPxDIzl6fb1efR8GujWZKD7CmF704s=;
	b=rz0qvUIycmzF6N6796sh0znHJRJL6Ut8qIdwGTrbuAXIsPSJtlaqj6TUys3jJK31gG0FB6
	VWUxQI6ckGxFQ6p0rRr91Vw+Cy0pUb+bRM2eZ3ZkUzoxE8HhtVp9SRuAM5cyFi6H9u6yQC
	FUIC/68WxFqnU3FYU+tOcl0gTEZ2EG8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61B4113A63;
	Tue, 16 Sep 2025 06:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xe1MFF0ByWijdAAAD6G6ig
	(envelope-from <antonio.feijoo@suse.com>); Tue, 16 Sep 2025 06:19:09 +0000
From: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Subject: [PATCH RESEND] powerpc/boot: Add missing compression methods to usage
Date: Tue, 16 Sep 2025 08:18:40 +0200
Message-ID: <20250916061840.5492-1-antonio.feijoo@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,csgroup.eu,vger.kernel.org,lists.ozlabs.org,suse.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

lzma and lzo are also supported.

Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
---
 arch/powerpc/boot/wrapper | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 3d8dc822282a..50607bc47d05 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -21,7 +21,7 @@
 #		(default ./arch/powerpc/boot)
 # -W dir	specify working directory for temporary files (default .)
 # -z		use gzip (legacy)
-# -Z zsuffix    compression to use (gz, xz or none)
+# -Z zsuffix    compression to use (gz, xz, lzma, lzo or none)
 
 # Stop execution if any command fails
 set -e
@@ -69,7 +69,7 @@ usage() {
     echo 'Usage: wrapper [-o output] [-p platform] [-i initrd]' >&2
     echo '       [-d devtree] [-s tree.dts] [-e esm_blob]' >&2
     echo '       [-c] [-C cross-prefix] [-D datadir] [-W workingdir]' >&2
-    echo '       [-Z (gz|xz|none)] [--no-compression] [vmlinux]' >&2
+    echo '       [-Z (gz|xz|lzma|lzo|none)] [--no-compression] [vmlinux]' >&2
     exit 1
 }
 
-- 
2.51.0


