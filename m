Return-Path: <linux-kernel+bounces-895807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7620DC4EFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC13A4E49AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B992A36C5A3;
	Tue, 11 Nov 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHoRgqxf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD8B355041;
	Tue, 11 Nov 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877871; cv=none; b=sTrLsX/2ajNdNxrtwBfRgrGcyslE4U9YkWxLwUNLqododLXoX04ZgLId/G8jlQglwHAndntpX8d60ccWJbOo+4wK/BJyIP8F+F36wjHvaq9cNk6Wkypjh3m0z8ryEPDUifDA6PSuSDeCXFbIhW7qW3NOYM80uQ4ZfaTG6on75Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877871; c=relaxed/simple;
	bh=JHGD5/Ti5dkXRBDtVWfhD0shk250SHYOSoMNMVMSORY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CpsJwjFcrHYSwHViaA0wFbF/XLc5LhG5/7zHcHZnnykMbMHwUIsd0BYzpun84C247GmL6r8EcJ0rs9LaOxVORvl9qbX5cD05N3KmzZNIXPVcBb7djFFV6tryCMW1j0eIMdVmdpBxM22UmdFQNr/tGwXpYJSDv/f+5wKVIzX1a0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHoRgqxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC363C4CEF7;
	Tue, 11 Nov 2025 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762877870;
	bh=JHGD5/Ti5dkXRBDtVWfhD0shk250SHYOSoMNMVMSORY=;
	h=From:To:Cc:Subject:Date:From;
	b=DHoRgqxfVJvYMNeAxheOuNNiYbwm4F05Mw65ZbPX4fcrYSH90GxWpooxACS6CMrsb
	 auKhsfgvF9OZbLcGGXUc/IPa2KL2m+k2rxy0Y6K3VzLi+z4SlmH5Bg5QrQ9gTNRPKS
	 oJTddU3OAP9pbOmgEB425xbJk3emWK8bAM+WBCf1Z727b4WBXWbvfEHopJ4wmgH4pD
	 YJ9FLqn8eLm5pwgcd2WsAdhn+VstcRf/EnDLf47ZNC/1wU1g2fWLmm30gDuHs9zm4Q
	 X+/QM5nKHF9DL94LFv38I4EsXUqgqhSW0grvM7GyJAOt0+oij5PfAyEBZvALR5w20U
	 4mzv+7SI6JQ2Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vIr40-00000007s4Z-1Nmj;
	Tue, 11 Nov 2025 17:17:48 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Convert get_feat to Python
Date: Tue, 11 Nov 2025 17:17:41 +0100
Message-ID: <cover.1762877066.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

That's the final series to complete the migration of documentation
build: it converts get_feat from Perl to Python.

With that, no Sphinx in-kernel extensions use fork anymore to call
ancillary scripts: everything is now importing Python methods
directly from the libraries.

As we don't have a definition yet for the location of the Python
libraries yet, I opted to place the parse features library inside
tools/docs/lib. It shouldn't be hard to move it elsewhere once we
define a better place for them.

There's nothing special on this conversion: it is a direct translation,
almost bug-compatible with the original version (*).

(*) I did solve two or three caveats on patch 1.

Most of the complexity of the script relies at the logic to produce
ReST tables. I do have here on my internal scripts a (somewhat) generic
formatter for ReST tables in Python. I was tempted to convert the logic
to use it, but, as this could cause regressions, I opted to not do it
right now, mainly because the matrix table logic is complex. Also,
I'm tempted to modify a little bit the output there, but extra tests
are required to see if PDF output would work with complex tables (I
remember I had a problem with that in the past). So, I'm postponing
such extra cleanup.

Mauro Carvalho Chehab (3):
  tools/docs/get_feat.py: convert get_feat.pl to Python
  Documentation/sphinx/kernel_feat.py: use class directly
  get_feat.pl: remove it, as it got replaced by get_feat.py

 Documentation/sphinx/kernel_feat.py |  24 +-
 tools/docs/get_feat.pl              | 641 ----------------------------
 tools/docs/get_feat.py              | 225 ++++++++++
 /parse_features.py    | 494 +++++++++++++++++++++
 4 files changed, 732 insertions(+), 652 deletions(-)
 delete mode 100755 tools/docs/get_feat.pl
 create mode 100755 tools/docs/get_feat.py
 create mode 100755 tools/docs/lib/parse_features.py

-- 
2.51.1



