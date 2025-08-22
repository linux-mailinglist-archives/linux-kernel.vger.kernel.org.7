Return-Path: <linux-kernel+bounces-782123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1230B31B83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF856434B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC9312818;
	Fri, 22 Aug 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKa5TAxQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6022730748F;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=T8M6l2Xxtlsyc+T5UykSbXuQmjh5APYJgdUM+IuU4pwmZRhFxEbuoQZDO88/wOFa5DLCOXK59Dxf26oRSixCwcDbTNn6c22tkIHRGzmfAOCbkQ4n3KQTHYhxciwu6iQAr/gSk681jLeB3YJWNghLkRP/Uhqge5pfwoscc2ymAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=XDxTPT2c6W8eHR7BT6Ec6vb15gsGsFJ8CPPzepOj7LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtyvvABDfvBYhTjjeGdQBHp0LVPNXSTD16dmDWwl9+xGCbBstgEJqZ5bryADrywO/7kNJKQZl1yLIeZOkWTH8bCwUbw+1MvAGgKKR6Kh5hzIk++96gq1e6IkcDORL1Lv4fyRUWIQYYv+LSZtVUdFeeP3O9IIpfZCKP/HQz/yg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKa5TAxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C15C4CEED;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=XDxTPT2c6W8eHR7BT6Ec6vb15gsGsFJ8CPPzepOj7LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKa5TAxQ4kuKEqZ7waaDQnnY0ZlPBzABftighqhaZ7U19xSAhr7AvsZrOv404D8i/
	 lMgNFTcTSllxoFAkeyuoS6JcnJnIpQ8/F2sD3wyy2AYvmk9fNz7D/6jIi61z82KugT
	 zm0fOLHPsYsU89KdAn4/bjy91vYmmiV0KERJMaI5aB1spxet6cDQsxUB4pqQiFdIpM
	 FZtm/+jN4U446VHNm1532YE+XIvQVnAtyWRcA9ipphxm4AsNceG65FMNblBLYEnvJa
	 T6nAffR3+TZQW+Wifq63UJ0pvZlzu7DArK7lg31miyWu7F/ESyfmN/XzbtMq83CRnt
	 qBXnnRjKfU9eg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCqv-0YfL;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/24] docs: parse-headers.pl: improve its debug output format
Date: Fri, 22 Aug 2025 16:19:13 +0200
Message-ID: <1064011717951eac257889a3032303c9d4440711.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Change the --debug logic to help comparing its results with
a new python script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parse-headers.pl | 31 ++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/sphinx/parse-headers.pl b/Documentation/sphinx/parse-headers.pl
index 7b1458544e2e..560685926cdb 100755
--- a/Documentation/sphinx/parse-headers.pl
+++ b/Documentation/sphinx/parse-headers.pl
@@ -31,8 +31,6 @@ my %enums;
 my %enum_symbols;
 my %structs;
 
-require Data::Dumper if ($debug);
-
 #
 # read the file and get identifiers
 #
@@ -197,6 +195,9 @@ if ($file_exceptions) {
 		} else {
 			$reftype = $def_reftype{$type};
 		}
+		if (!$reftype) {
+		    print STDERR "Warning: can't find ref type for $type";
+		}
 		$new = "$reftype:`$old <$new>`";
 
 		if ($type eq "ioctl") {
@@ -229,12 +230,26 @@ if ($file_exceptions) {
 }
 
 if ($debug) {
-	print Data::Dumper->Dump([\%ioctls], [qw(*ioctls)]) if (%ioctls);
-	print Data::Dumper->Dump([\%typedefs], [qw(*typedefs)]) if (%typedefs);
-	print Data::Dumper->Dump([\%enums], [qw(*enums)]) if (%enums);
-	print Data::Dumper->Dump([\%structs], [qw(*structs)]) if (%structs);
-	print Data::Dumper->Dump([\%defines], [qw(*defines)]) if (%defines);
-	print Data::Dumper->Dump([\%enum_symbols], [qw(*enum_symbols)]) if (%enum_symbols);
+	my @all_hashes = (
+		{ioctl      => \%ioctls},
+		{typedef    => \%typedefs},
+		{enum       => \%enums},
+		{struct     => \%structs},
+		{define     => \%defines},
+		{symbol     => \%enum_symbols}
+	);
+
+	foreach my $hash (@all_hashes) {
+		while (my ($name, $hash_ref) = each %$hash) {
+			next unless %$hash_ref;  # Skip empty hashes
+
+			print "$name:\n";
+			for my $key (sort keys %$hash_ref) {
+				print "  $key -> $hash_ref->{$key}\n";
+			}
+			print "\n";
+		}
+	}
 }
 
 #
-- 
2.50.1


