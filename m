Return-Path: <linux-kernel+bounces-734466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2873B08225
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1D71A603C8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16D41B4223;
	Thu, 17 Jul 2025 01:11:31 +0000 (UTC)
Received: from omta003.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB881AF4D5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714691; cv=none; b=jCv8UvDOy7CRA9SVm+ZRlmsNHjZd6j+RWCtNFlXAXofqklMFONStafnqeil1FgBthAxdqBrkmyGJNo1Z9LII7GVCi7b38WKknMIR3Kh5QYQydkFQGOmnxu/qVO0s8LGTaqdJYQlhr7qZkm+tUTP0Hya7hAIK8ph6lfqf2wQQ3NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714691; c=relaxed/simple;
	bh=4thS/Bnp0aiazOo6lbSDdbif3cnQB5fH31T1cuUzc04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0p9s+2TC5xlaQMDqi5betm7WR6xvp3gxbDc7Jrk7NB48ZZzMIBu3yGzGkPyW28twd4na7F8/n0bvSYoyqMjlVmogiSlNrZK7DOVXvk7+G6TQO4khfvvQz8KxFo+MWb0vONfkYRaq0DUY/wmJUOEeP62qOrMEKSpy2Od278SSvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTPS
	id c2DeuFFCx9JM2cD9euOMAV; Thu, 17 Jul 2025 01:11:22 +0000
Received: from cabot.adilger.int ([70.77.200.158])
	by cmsmtp with ESMTP
	id cD9duZToTJhBPcD9eubucj; Thu, 17 Jul 2025 01:11:22 +0000
X-Authority-Analysis: v=2.4 cv=QY3Fvdbv c=1 sm=1 tr=0 ts=68784dba
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=RPJ6JBhKAAAA:8
 a=QQdngafKVaWhNDnW0jYA:9 a=fa_un-3J20JGBB2Tu-mn:22
From: Andreas Dilger <adilger@dilger.ca>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org,
	Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] checkpatch: ignore deleted lines for comment context
Date: Wed, 16 Jul 2025 19:11:21 -0600
Message-ID: <20250717011121.684303-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJxgO6F5vPHze/kIsbysSiyaFbs8S/fI5kjb5jS+z+9fzDczhI5GaKHotiTwdQDBcVzH5ec5TSBoHq+BKR/kHAdrKwNWgSyqFca2FmeqbS2gS2URDLaP
 M/ZROIXgdxZGgccIsuIabvbn4S5vYELrvkuCU9jf//LWysozDa5N0w6dEFQhgyzhwJCjQ6NyKDige5FZMa54LJBz0994DWwDsaIoESk2omfobzZ+/vZ+lZZt
 AhYIZvPJApz55SUIZAw3gljjFmXddUCx9zApsZXb16abMSi10VZF1X94Aw6dVQpA

Don't consider lines being removed by a patch as part of the context.
Otherwise, false "WARNING: memory barrier without comment" and similar
warnings can be reported when a comment exists on the previous line.

For example, a change like below was previously incorrectly flagged:

	/* matched by smp_store_release() in some_function() */
 -	if (smp_load_acquire(&list->tail) == head))
 +	if (smp_load_acquire(&list->tail) == head) && flags == 0)

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 664f7b7a622c..dc90a0871a0e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1989,6 +1989,7 @@ sub ctx_locate_comment {
 	for (my $linenr = $first_line; $linenr < $end_line; $linenr++) {
 		my $line = $rawlines[$linenr - 1];
 		#warn "           $line\n";
+		next if ($line =~ /^-/); # ignore lines removed by patch
 		if ($linenr == $first_line and $line =~ m@^.\s*\*@) {
 			$in_comment = 1;
 		}
-- 
2.43.5


