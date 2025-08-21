Return-Path: <linux-kernel+bounces-780021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35313B2FC79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0474AA36CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6992877C9;
	Thu, 21 Aug 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjCPEr+S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E72279791;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=sQAob0fqpio84UkoNHPIVJhWa/NVAc+rfSgQybzE6qsUoqIqjlnFgZEj/Yodvs/v0NKnwBmZ3hsQyfy4CXaFOv+BQdlsuoVCRYwjrwsJFrAhfewLA32tSUTCHHUo0bv+B+AJJtzySrPffSa+/cxB/1ORXlq6bLDh9GlZ78Qtw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=XDxTPT2c6W8eHR7BT6Ec6vb15gsGsFJ8CPPzepOj7LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEQV5HtrA/WcFw4+R9AXahMpX3/C38kyJNTh3U0kleUiHzKWrQufro+ZKt9dsSCkHJRRaIrCHHJXa+5CAWzHqKw0hT9jideMhGlcce9V63K9A1xWsbcN/RCdSyZIEt5Q/5o4BdKFMo2sjs7CsekyaOAehzWT+YIBHmcHR+ufF3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjCPEr+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6E1C4CEEB;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=XDxTPT2c6W8eHR7BT6Ec6vb15gsGsFJ8CPPzepOj7LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjCPEr+S/XdiTJptR5n3uyAVivqrZGWjiLttZqAJf4tUJZ89h0Wj0euE5S4i3bZbX
	 9zrmAe2gI0pyeg899Mq3yYYSzGn+eWzuOocK3XNMYy1p+yNg748v4QT1Apzku+u2BB
	 8335srwSXNgxc1UFYX4wRb94bMX9VpwTgv1iFxAfcuC+I/1sL/ydi4qCldmLznAsGS
	 rSElgV2+oPFpvwbb8Hdo7WIJv2uBC5Ot8+rnxdWhf1JuqRzJCxkXf5B0Syk1pQL/Cs
	 Gvs04mE/sYrxJS8RU1OA2TYC6rdUWoNl7Ccquk5I4mSJNaKsg68SH84lLY5/DWWOEm
	 Iy7xsVh0lVFPw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT84-028y;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/24] docs: parse-headers.pl: improve its debug output format
Date: Thu, 21 Aug 2025 16:21:07 +0200
Message-ID: <3d23cd095d482715284fc2e0a46199b00e10e851.1755784930.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755784929.git.mchehab+huawei@kernel.org>
References: <cover.1755784929.git.mchehab+huawei@kernel.org>
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


