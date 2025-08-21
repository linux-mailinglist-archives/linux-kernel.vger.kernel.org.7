Return-Path: <linux-kernel+bounces-779192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB01B2F04D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA2C1698F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779E62E8E12;
	Thu, 21 Aug 2025 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxk9Yt7J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD928315A;
	Thu, 21 Aug 2025 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763002; cv=none; b=eFI5/PQDhjbM2U77mnUvd0qAHv3uJIaywFkl2r6djWTfQd+kTLuCBetx8CK/Do9inosUFXEfWXAPKBGET8zccksR9UeMgsMhDfb2CjQeZVzWZkvoDUA1dzIg0GDCYA9mzEsPuGZrmNysCQ8DS0D2zllpP0HEtTe15LldYGmVvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763002; c=relaxed/simple;
	bh=al2HgMvixL4DhM3Vv6wS8bxJ0NVBLNWxsvmiKZ2jAj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMZi/zRHqaLgwMTneODsZrkWWbY0ZMZnoNmX94OIdzgpsp5vOLc60n6SD6jRqSA6iBdpYOZWPx6fDGFeZFBKe8GJhpNx6eF5b30jgLMaYhWG9MInS7PZJmysJ69O3CfGYgugrHKrN0fbnmzqXayszHuP3oXt4mQyKgvtuWOf8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxk9Yt7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CA5C4CEED;
	Thu, 21 Aug 2025 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755763001;
	bh=al2HgMvixL4DhM3Vv6wS8bxJ0NVBLNWxsvmiKZ2jAj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qxk9Yt7JNe9dCaXigKMrkvOAbGMEwINyljQdIKVUdSK8X3RsQOcOs7HGQtWHbzAMI
	 QcsqnQrF6bo1KCE0ahBASGzak7bvmQe5Ptk157isWhx7sWIf58pkwfk8ONuo/+sFWW
	 PUNNuj/4Zl0N6U5MR5p5vJQ0N91F9O/ZaoyXxy1WsruN2yGzakvqgIjFdyslwz5vYr
	 QYLMTr/bmiPzRPQ2xjX3fBtUbgYVjJnZ3jBLss+JK2h16Ph4JmsgFAe1YeAuYXLK8w
	 dSbuzN1tt2ehlOKFtFRfASRgAs5WrA+TO5yUloYkuwO4WLHUOThglaTlOiOb90G3sf
	 BJK6KNuYMhP5Q==
Date: Thu, 21 Aug 2025 09:56:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <20250821095637.5dbe9533@foz.lan>
In-Reply-To: <20250821095221.5e6510f5@foz.lan>
References: <20250817154544.78d61029@foz.lan>
	<b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
	<87y0rg7e35.fsf@trenco.lwn.net>
	<16b48826-6634-4ec9-86a0-7ddb59ce3bed@gmail.com>
	<20250819030239.41a2e97f@foz.lan>
	<142b209d-613a-4659-a0f7-27efa8c6be85@gmail.com>
	<20250819153200.3c2b2ff6@foz.lan>
	<08c3a7eb-0425-4709-a3ea-6d1d726fd3c8@gmail.com>
	<20250820091530.068c4b62@foz.lan>
	<3990f1c5-2108-44fe-913f-97ae3bb1ff42@gmail.com>
	<xik6a2kb3mge5xh2mbdtc4p3ikbr4mnjlkk4ujc4sfztb3iqnr@tc76jva4smpm>
	<526d1aee-d401-4f04-8ddc-122f1fef7905@gmail.com>
	<5fb6ce64-747b-46e4-b135-0d987334a12c@gmail.com>
	<20250821095221.5e6510f5@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 21 Aug 2025 09:52:21 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Thu, 21 Aug 2025 09:09:41 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
> > Hi,
> > 
> > Let me do a quick follow up.
> > I messed up the table.
> > 
> > On Thu, 21 Aug 2025 08:53:04 +0900, Akira Yokosawa wrote:
> > > Hi,
> > > 
> > > Commenting on your observation quoted below.
> > > 
> > > On Wed, 20 Aug 2025 18:48:10 +0200, Mauro Carvalho Chehab wrote:
> > > [...]
> > >   
> > >> If you want a more comprehensive answer:
> > >>
> > >> LaTeX is highly dependent lots of packages, including fonts. The
> > >> reason why you can't reproduce the font issues with Docker
> > >> (I wasn't able to reproduce with Docker here as well) is
> > >> probably due to either packaging differences between the
> > >> two containers, due to different environment technologies
> > >> or even due to the way Docker and LXC handles OS virtualization.
> > >>  
> > > 
> > > I'm not saying there is no difference between Docker and LXC.
> > > 
> > > Can you fill in ???? cells in the table below ?  
> > I mean                                          with this series applied
> > 
> > > Docker column is my observation of "FROM ubuntu:plucky" podman runs.
> > > 
> > >  "make SPHINXDIRS=gpu pdfdocs" under Ubuntu Plucky
> > >   
> > 
> > I meant:
> > 
> >      --------------- --------- ----------
> >      SVG --> PDF     Docker    LXC
> >      --------------- --------- ----------
> >      imagemagick     FAIL      ????
> >      inkscape        SUCCESS   ????
> >      imagemagick [*] FAIL      ????
> >      --------------- --------- ----------
> 
> This is after my series, with doesn't deal with imagemagick/inkscape,
> it only fixes broken texlive dependencies and fix font handling:
> 
> # (dpkg -l |grep -i magick; dpkg -l |grep inkscape)|grep ii
> ii  imagemagick                   8:7.1.1.43+dfsg1-1                    amd64        image manipulation programs -- binaries
> ii  imagemagick-7-common          8:7.1.1.43+dfsg1-1                    all          image manipulation programs -- infrastructure
> ii  imagemagick-7.q16             8:7.1.1.43+dfsg1-1                    amd64        image manipulation programs -- quantum depth Q16
> ii  libmagickcore-7.q16-10:amd64  8:7.1.1.43+dfsg1-1                    amd64        low-level image manipulation library -- quantum depth Q16
> ii  libmagickwand-7.q16-10:amd64  8:7.1.1.43+dfsg1-1                    amd64        image manipulation library -- quantum depth Q16
> 
> # make SPHINXDIRS=gpu pdfdocs
> 
> Summary
> =======
> gpu: gpu/pdf/gpu.pdf
> 
> All PDF files were built.
> 
> # rm -rf Documentation/output/gpu/*
> # (dpkg -l |grep -i magick; dpkg -l |grep inkscape)|grep ii
> ii  imagemagick                     8:7.1.1.43+dfsg1-1                    amd64        image manipulation programs -- binaries
> ii  imagemagick-7-common            8:7.1.1.43+dfsg1-1                    all          image manipulation programs -- infrastructure
> ii  imagemagick-7.q16               8:7.1.1.43+dfsg1-1                    amd64        image manipulation programs -- quantum depth Q16
> ii  libimage-magick-perl            8:7.1.1.43+dfsg1-1                    all          Perl interface to the ImageMagick graphics routines
> ii  libimage-magick-q16-perl        8:7.1.1.43+dfsg1-1                    amd64        Perl interface to the ImageMagick graphics routines -- Q16 version
> ii  libmagickcore-7.q16-10:amd64    8:7.1.1.43+dfsg1-1                    amd64        low-level image manipulation library -- quantum depth Q16
> ii  libmagickwand-7.q16-10:amd64    8:7.1.1.43+dfsg1-1                    amd64        image manipulation library -- quantum depth Q16
> ii  inkscape                   
> 
> # rm -rf Documentation/output/gpu/*
> # (dpkg -l |grep -i magick; dpkg -l |grep inkscape)|grep ii
> ii  inkscape                        1.2.2-8build1                         amd64        vector-based drawing program
> 
> # make SPHINXDIRS=gpu pdfdocs
> 
> Summary
> =======
> gpu: gpu/pdf/gpu.pdf
> 
> > >     --------------- --------- ----------
> > >     SVG --> PDF     Docker    LXC
> > >     --------------- --------- ----------
> > >     imagemagick     FAIL      FAIL
> > >     inkscape        SUCCESS   ????
> > >     imagemagick [*] FAIL      ????
> > >     --------------- --------- ----------
> > > 
> > > [*] after installing both inkscape and imagemagick, remove inkscape
> > >     with all its dependencies kept.
> > > 
> > > Do you see any difference between Docker and LXC columns in the table?
> > > I'm all ears.
> 
> Yes. After having texlive dependencies fixed, and addressing the broken
> conf.py file that is not aligned with modern Sphinx practices, it passed
> on all three scenarios.
> 
> Please notice that addressing image was not the intent of this series.
> 
> The goal was *just* to fix texlive dependencies and fix text font
> mapping that were causing troubles on Ubuntu and on other distros.
> 
> 
> Thanks,
> Mauro

Thanks,
Mauro

Hmm.. I ended doing the above tests with this patch on my pile.
It could be affecting the results, as it prevents kfigure.py to
crash when writing PDF output.


commit df1602df0da3a6254d58a782654e7f2e60512dc8
Author: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Wed Aug 20 09:17:50 2025 +0200

    docs: kfigure.py: don't crash during read/write
    
    By default, Python does a very bad job when reading/writing
    from files, as it tries to enforce that the character is < 128.
    Nothing prevents a SVG file to contain, for instance, a comment
    with an utf-8 accented copyright notice - or even an utf-8
    invalid char.
    
    While testing PDF and html builds, I recently faced one build
    that got an error at kfigure.py saying that a char was > 128,
    crashing PDF output.
    
    To avoid such issues, let's use PEP 383 subrogate escape encoding
    to prevent read/write errors on such cases.
    
    Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index ad495c0da270..8ba07344a1c8 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -88,7 +88,7 @@ def mkdir(folder, mode=0o775):
         os.makedirs(folder, mode)
 
 def file2literal(fname):
-    with open(fname, "r") as src:
+    with open(fname, "r", encoding='utf8', errors='surrogateescape') as src:
         data = src.read()
         node = nodes.literal_block(data, data)
     return node
@@ -355,7 +355,7 @@ def dot2format(app, dot_fname, out_fname):
     cmd = [dot_cmd, '-T%s' % out_format, dot_fname]
     exit_code = 42
 
-    with open(out_fname, "w") as out:
+    with open(out_fname, "w", encoding='utf8', errors='surrogateescape') as out:
         exit_code = subprocess.call(cmd, stdout = out)
         if exit_code != 0:
             logger.warning(
@@ -533,7 +533,7 @@ def visit_kernel_render(self, node):
     literal_block = node[0]
 
     code      = literal_block.astext()
-    hashobj   = code.encode('utf-8') #  str(node.attributes)
+    hashobj   = code.encode('utf-8', errors='surrogateescape')) #  str(node.attributes)
     fname     = path.join('%s-%s' % (srclang, sha1(hashobj).hexdigest()))
 
     tmp_fname = path.join(
@@ -541,7 +541,7 @@ def visit_kernel_render(self, node):
 
     if not path.isfile(tmp_fname):
         mkdir(path.dirname(tmp_fname))
-        with open(tmp_fname, "w") as out:
+        with open(tmp_fname, "w", encoding='utf8', errors='surrogateescape') as out:
             out.write(code)
 
     img_node = nodes.image(node.rawsource, **node.attributes)



