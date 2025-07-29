Return-Path: <linux-kernel+bounces-749875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D7B15407
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E879F5482D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4712BD5BF;
	Tue, 29 Jul 2025 20:04:14 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FEE29B8CC;
	Tue, 29 Jul 2025 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753819454; cv=none; b=PG4G6Ip95yzR/vUAgS/Ksr7Q11hsjqDgzkFXd6hng3rO26Xl2drvZTjSm3/J1T40+PbD0Luzghdpkn2sGh0zaUjZRSSSbS2Wim+hvurRqiG2iZyM02fmukC3vm6H6Z6NuPnmRKxLWOfAY7ryUKQM48Z6SNBNIb3Ntas68FFPZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753819454; c=relaxed/simple;
	bh=QtkooK38Irpas0y98nQf3r6HgWmVNb6aaP3F6sADO0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8E+hdXorvIEMK1aVoYF45eMT4a8e68ze2hwoEp1FdwEoo3IW/04ruvANoSZav9Gm9eB26ns2VGllqzP4QswmpdFI+UVdefGIiIz7uXMihjL3WzTLtRfsiKQunClEpWn02wVWhsCdAqE9J2yr4JsKZHRZv/U7c3mI4Yn4bg75Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:d071:2bab:ab9:4510])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 13DE6415B4;
	Tue, 29 Jul 2025 20:04:10 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:d071:2bab:ab9:4510) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: joe@perches.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCH 3/3] checkpatch.pl: --fix support for `//` comments rust
 private items
Date: Tue, 29 Jul 2025 21:04:02 +0100
Message-ID: <20250729200402.35241-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729200158.35050-1-contact@arnaud-lcm.com>
References: <20250729200158.35050-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175381945103.14371.5199097567942047642@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Extend the Rust private item documentation checker (added in the previous
patch) to support automatic fixes when the `--fix` option is enabled.

Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ac403d270eb4..d01d993d8a9f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3069,6 +3069,9 @@ sub process {
             	for (my $i = $start_l; $i <= $end_l; $i++) {
                 	next unless $rawlines[$i - 1] =~ m@^\+//([^/].*)$@;
                 	push @comment_lines, $rawlines[$i - 1];
+					if($fix) {
+						$fixed[$i - 1] =~ s/^\+(\/\/)/+$1\//;
+					}
 				}
 				my $formatted_comments = join("", map {
 					s/\n$//;
-- 
2.43.0


