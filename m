Return-Path: <linux-kernel+bounces-870328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F1EC0A790
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901253AEFF5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EEB2DC771;
	Sun, 26 Oct 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DTreRBbr"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0C2D2483;
	Sun, 26 Oct 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482552; cv=none; b=gtlfkiYNf5fdBsaGdy6gEINhGrt7JxiNWf+FBHJd2+3MEFgxK7o2dg9tUNdJWw8ZcbgGPwl/m2XiiQH7CCGH6m8iqf1oqOyF+RyBVKBbunklMDLCMZVWdgrChupimksZHR7SSzpyTpsi4MqtNArT2GouU+69W7A6fRRVcLyGKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482552; c=relaxed/simple;
	bh=zpFmr2bAa3y9bCKAGucQbllnSsTKjY7O34zopgzM60c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jvlgm+x4I9Jis8s2sz27rN2vors7PPyDibu2xr7rEsHDmT93p2RroPegtmckUMQaS8I7+rfblCOVqTMHfBLDx5a7Em6uJ5QDh0DxDleV5UR8FDPVfG1QfJEVynRdEh2ko8Qs4hnkjhWAWtdjMhUd/eQleMbcrDe5pSPolmkw8jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DTreRBbr; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fXIJPHYO42z1iATORgKH8y5WkIUpTXH1/3Hr32G1JXY=; t=1761482550; x=1761914550; 
	b=DTreRBbruTfqLA80psOcOoxGT0+f/eVY6VTc2yBXCJ9I4vG6bY8xvIwU7rtSJIHWQhoXDOxmeKV
	84GTaDTSOIJDr4hjgTXAdsL7MkOSYQlB11HII02pI2yLBn37zxLUUTe8xYLiIl9aMRYpauKy4Mf96
	7ER/LaMPDdZJojF7QIv6JtZqXBnM4zMwfqKTS1QCO62zEQ6co1eMbJz9WuZfEPQR7Kp9C/3A3VTyq
	6gFxhlmJJG1RysI7TGJrRpGbHA3GOJUrJ5D/47N2VJGC2Q9SQWpiGjJRilsjSYaBYigVdUth7SptE
	cVTlJ09XbxxB6KXjg3zl1HWspdqdKvWnWzNQ==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04k-001mX6-0U;
	Sun, 26 Oct 2025 13:42:22 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/30] docs: reporting-issues: rework
Date: Sun, 26 Oct 2025 13:41:51 +0100
Message-ID: <cover.1761481839.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482550;db804c08;
X-HE-SMSGID: 1vD04k-001mX6-0U

Hi! This patch reworks various parts of our text on bug reporting. I
started working on it for six reasons:

* I noticed that even experienced Linux users had trouble with the TLDR
  text, despite it being already quite long.

* I noticed a few areas where people were struggling when reporting
  issues and saw potential for improving the situation somewhat by
  rearranging and fine-tuning the order and the description of the
  step-by-step guide a little.

* I wanted to add a simple to follow "is this regression maybe known
  already?" option to avoid unnecessary trouble for reporters.

* I wanted to improve the interaction with
  Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst,
  which has a few bits with roots in reporting-issues.rst, but covers
  verifying bugs and bisecting a lot better.

* I wanted to make it easier to jump to the reference section and back
  by adding internal links, similar to how we did it in
  Documentation/admin-guide/quickly-build-trimmed-linux.rst and
  Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst.

* I found the tone of the old text somewhat off-putting; I think I made
  it better in a lot of places, but I suspect I missed a few areas that
  needed treatment – and maybe did not go far enough in some others. So
  please let me know if you spot cases that are too dim, some external
  feedback really would help.

 I worked on-and-off on this for maybe two years and the problem is:
what started as fine tuning in various places piled up. That together
with the newly added links & anchors and some text movements makes the
patchset huge. When you ignore those two aspects and look at individual
patches using a word diff algorithm it looks a lot less scary, but it
remains big – and thus sadly puts some load on reviewers and
translators. Sorry. I think it's worth it and tried to split things up
to facilitate handling.

If you want to see how the resulting text looks like, check out:
https://www.leemhuis.info/files/misc/Reporting%20issues%20%e2%80%94%20The%20Linux%20Kernel%20documentation.html

Feel also free to fix any typos you spot
https://docs.google.com/document/d/1To4xVY8M6BDMBXEhEbaXuacZESdMzNFGECHk1a6nVPI/edit?usp=sharing,
I'll pick those up for the next version. You can also add notes with
suggestions there. But please do not add anything that might be covered
by copyright.

Ciao, Thorsten

To: Jonathan Corbet <corbet@lwn.net>
CC: linux-doc@vger.kernel.org

Thorsten Leemhuis (30):
  docs: reporting-issues: mention text is best viewed rendered
  docs: reporting-issues: tweak the reference section intro
  docs: reporting-issues: add conclusion to the step-by-step guide
  docs: reporting-issues: add proper appendix
  docs: reporting-issues: outline why reporting is complicated
  docs: reporting-issues: replace TLDR guide with more of an into
  docs: reporting-issues: explain need for fresh vanilla kernel
  docs: reporting-issues: add step about processing issues separately
  docs: reporting-issues: tell users to check the kernel log
  docs: reporting-issues: move 'check tainted flag' upwards
  docs: reporting-issues: improve first tainted check
  docs: reporting-issues: move 'check environment' upwards
  docs: reporting-issues: improve environment check
  docs: reporting-issues: improve text about checking for existing
    issues
  docs: reporting-issues: improve text on classifying the bug
  docs: reporting-issues: add fast-track for regressions
  docs: reporting-issues: move text on 'check MAINTAINERS file' upwards
  docs: reporting-issues: improve text on looking up place to report
  docs: reporting-issues: move text on 'check other places' upwards
  docs: reporting-issues: improve text on check other places
  docs: reporting-issues: improve text on backup et. al
  docs: reporting-issues: move text on 'initial write-up' upwards
  docs: reporting-issues: improve text on initial write-up
  docs: reporting-issues: improve text on bug verification
  docs: reporting-issues: improve text on non-regressions in stable
  docs: reporting-issues: improve text on second search
  docs: reporting-issues: make collecting files a separate step
  docs: reporting-issues: separate steps for optimizing and submitting
    reports
  docs: reporting-issues: separate steps for follow-up tasks
  docs: reporting-issues: fix a few line breaks

 .../admin-guide/reporting-issues.rst          | 2958 ++++++++---------
 1 file changed, 1426 insertions(+), 1532 deletions(-)


base-commit: b14a05303f06d951c6ef7e23e5c8f3e3be21e17e
-- 
2.51.0


