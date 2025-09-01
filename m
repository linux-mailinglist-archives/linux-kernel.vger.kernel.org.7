Return-Path: <linux-kernel+bounces-794807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C692B3E78F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6CB4467C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94706346A18;
	Mon,  1 Sep 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYRAiQ75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6369341650;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737758; cv=none; b=kPFCvKKtVhlJRR9/PDyt01vR+ly7o7EajRMkHRZvn2zwbjquBvtbjAyjQQ9DQ+7hoig9PfOK6dIzV0TXUR3cFZwuKApfJB9XFI1uC2AsjAh+ZrWJQ1UNCAL0EIHgV28Ay2bvXQ8UtKj/vjlzh8fz8LGILvYqLH19V08FYXD6m5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737758; c=relaxed/simple;
	bh=xoCXkgDpfSGLUQkbKhJPhF5dmK3td3hHAgXtwYxjVi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XyNri2skEhUbWmqAbYkLixVH8ThetkAFv9OO7ZdX0hYRaHFRn+/XuzQlfSxFJTx3ZO57j+ap+o5AsnF6/GReNtyxay70QnSHlLDNDG5LkYoqIidbPgQN/MLsuqKq9ZYUeSW9S8c/PC3Z1FwkcOWBGl01vFmZZJefPiXbZ9+ofbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYRAiQ75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EDEC16AAE;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737757;
	bh=xoCXkgDpfSGLUQkbKhJPhF5dmK3td3hHAgXtwYxjVi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYRAiQ75iyhp5fU1OlLlmyXC0FV+lg7387U2OVGjvzjT2Q19T94bQYlJFbdTBSojP
	 wYN5Y7rqxt7msW2XQCFRzpG+sZRcTV91OfLeCpDCDF2bEIO/25/9LwIgjqVT24pqw4
	 oeWLOAnx0kjJ4HormxWSUrOsYRpTnALtaGPUQehSP3GMa6T1W9/z+z7kA18ROPwvem
	 KuSXAUgKxWSyV2PUyLgNIdgr35la55mruZ/LgVDxyDgyg3vlq1zTcdsGDyDneyjkGs
	 LqJWW9pRYS8BmjRQ26/rM9b/Nx8KKMZZr47R/IPQZZ3U2lO/BSe+pvfO53hmED5hXr
	 ncl1EjB6tgb8w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut5jv-00000003G3w-3TU0;
	Mon, 01 Sep 2025 16:42:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/15] tools/docs: sphinx-build-wrapper: allow building PDF
  files in parallel
Date: Mon,  1 Sep 2025 16:42:29 +0200
Message-ID: <20eff278c995cd39535d723f538cff9a368ff8e1.1756737440.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756737440.git.mchehab+huawei@kernel.org>
References: <cover.1756737440.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Use POSIX jobserver when available or -j<number> to run PDF=0D
builds in parallel, restoring pdf build performance. Yet,=0D
running it when debugging troubles is a bad idea, so, when=0D
calling directly via command line, except if "-j" is splicitly=0D
requested, it will serialize the build.=0D
=0D
With such change, a PDF doc builds now takes around 5 minutes=0D
on a Ryzen 9 machine with 32 cpu threads:=0D
=0D
	# Explicitly paralelize both Sphinx and LaTeX pdf builds=0D
	$ make cleandocs; time scripts/sphinx-build-wrapper pdfdocs -j 33=0D
=0D
	real	5m17.901s=0D
	user	15m1.499s=0D
	sys	2m31.482s=0D
=0D
	# Use POSIX jobserver to paralelize both sphinx-build and LaTeX=0D
	$ make cleandocs; time make pdfdocs=0D
=0D
	real	5m22.369s=0D
	user	15m9.076s=0D
	sys	2m31.419s=0D
=0D
	# Serializes PDF build, while keeping Sphinx parallelized.=0D
	# it is equivalent of passing -jauto via command line=0D
	$ make cleandocs; time scripts/sphinx-build-wrapper pdfdocs=0D
=0D
	real	11m20.901s=0D
	user	13m2.910s=0D
	sys	1m44.553s=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 tools/docs/sphinx-build-wrapper | 158 +++++++++++++++++++++++---------=0D
 1 file changed, 117 insertions(+), 41 deletions(-)=0D
=0D
diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrap=
per=0D
index 580582a76c93..c884022ad733 100755=0D
--- a/tools/docs/sphinx-build-wrapper=0D
+++ b/tools/docs/sphinx-build-wrapper=0D
@@ -52,6 +52,8 @@ import shutil=0D
 import subprocess=0D
 import sys=0D
 =0D
+from concurrent import futures=0D
+=0D
 from lib.python_version import PythonVersion=0D
 =0D
 LIB_DIR =3D "../../scripts/lib"=0D
@@ -278,6 +280,82 @@ class SphinxBuilder:=0D
         except (OSError, IOError) as e:=0D
             print(f"Warning: Failed to copy CSS: {e}", file=3Dsys.stderr)=
=0D
 =0D
+    def build_pdf_file(self, latex_cmd, from_dir, path):=0D
+        """Builds a single pdf file using latex_cmd"""=0D
+        try:=0D
+            subprocess.run(latex_cmd + [path],=0D
+                            cwd=3Dfrom_dir, check=3DTrue)=0D
+=0D
+            return True=0D
+        except subprocess.CalledProcessError:=0D
+            return False=0D
+=0D
+    def pdf_parallel_build(self, tex_suffix, latex_cmd, tex_files, n_jobs)=
:=0D
+        """Build PDF files in parallel if possible"""=0D
+        builds =3D {}=0D
+        build_failed =3D False=0D
+        max_len =3D 0=0D
+        has_tex =3D False=0D
+=0D
+        #=0D
+        # LaTeX PDF error code is almost useless for us:=0D
+        # any warning makes it non-zero. For kernel doc builds it always r=
eturn=0D
+        # non-zero even when build succeeds. So, let's do the best next th=
ing:=0D
+        # Ignore build errors. At the end, check if all PDF files were bui=
lt,=0D
+        # printing a summary with the built ones and returning 0 if all of=
=0D
+        # them were actually built.=0D
+        #=0D
+        with futures.ThreadPoolExecutor(max_workers=3Dn_jobs) as executor:=
=0D
+            jobs =3D {}=0D
+=0D
+            for from_dir, pdf_dir, entry in tex_files:=0D
+                name =3D entry.name=0D
+=0D
+                if not name.endswith(tex_suffix):=0D
+                    continue=0D
+=0D
+                name =3D name[:-len(tex_suffix)]=0D
+=0D
+                max_len =3D max(max_len, len(name))=0D
+=0D
+                has_tex =3D True=0D
+=0D
+                future =3D executor.submit(self.build_pdf_file, latex_cmd,=
=0D
+                                         from_dir, entry.path)=0D
+                jobs[future] =3D (from_dir, pdf_dir, name)=0D
+=0D
+            for future in futures.as_completed(jobs):=0D
+                from_dir, pdf_dir, name =3D jobs[future]=0D
+=0D
+                pdf_name =3D name + ".pdf"=0D
+                pdf_from =3D os.path.join(from_dir, pdf_name)=0D
+=0D
+                try:=0D
+                    success =3D future.result()=0D
+=0D
+                    if success and os.path.exists(pdf_from):=0D
+                        pdf_to =3D os.path.join(pdf_dir, pdf_name)=0D
+=0D
+                        os.rename(pdf_from, pdf_to)=0D
+                        builds[name] =3D os.path.relpath(pdf_to, self.buil=
ddir)=0D
+                    else:=0D
+                        builds[name] =3D "FAILED"=0D
+                        build_failed =3D True=0D
+                except futures.Error as e:=0D
+                    builds[name] =3D f"FAILED ({repr(e)})"=0D
+                    build_failed =3D True=0D
+=0D
+        #=0D
+        # Handle case where no .tex files were found=0D
+        #=0D
+        if not has_tex:=0D
+            name =3D "Sphinx LaTeX builder"=0D
+            max_len =3D max(max_len, len(name))=0D
+            builds[name] =3D "FAILED (no .tex file was generated)"=0D
+            build_failed =3D True=0D
+=0D
+        return builds, build_failed, max_len=0D
+=0D
     def handle_pdf(self, output_dirs):=0D
         """=0D
         Extra steps for PDF output.=0D
@@ -288,7 +366,9 @@ class SphinxBuilder:=0D
         """=0D
         builds =3D {}=0D
         max_len =3D 0=0D
+        tex_suffix =3D ".tex"=0D
 =0D
+        tex_files =3D []=0D
         for from_dir in output_dirs:=0D
             pdf_dir =3D os.path.join(from_dir, "../pdf")=0D
             os.makedirs(pdf_dir, exist_ok=3DTrue)=0D
@@ -300,55 +380,51 @@ class SphinxBuilder:=0D
 =0D
             latex_cmd.extend(shlex.split(self.latexopts))=0D
 =0D
-            tex_suffix =3D ".tex"=0D
-=0D
-            #=0D
-            # Process each .tex file=0D
-            #=0D
-=0D
-            has_tex =3D False=0D
-            build_failed =3D False=0D
+            # Get a list of tex files to process=0D
             with os.scandir(from_dir) as it:=0D
                 for entry in it:=0D
-                    if not entry.name.endswith(tex_suffix):=0D
-                        continue=0D
+                    if entry.name.endswith(tex_suffix):=0D
+                        tex_files.append((from_dir, pdf_dir, entry))=0D
 =0D
-                    name =3D entry.name[:-len(tex_suffix)]=0D
-                    has_tex =3D True=0D
+        #=0D
+        # When using make, this won't be used, as the number of jobs comes=
=0D
+        # from POSIX jobserver. So, this covers the case where build comes=
=0D
+        # from command line. On such case, serialize by default, except if=
=0D
+        # the user explicitly sets the number of jobs.=0D
+        #=0D
+        n_jobs =3D 1=0D
 =0D
-                    #=0D
-                    # LaTeX PDF error code is almost useless for us:=0D
-                    # any warning makes it non-zero. For kernel doc builds=
 it=0D
-                    # always return non-zero even when build succeeds.=0D
-                    # So, let's do the best next thing: check if all PDF=0D
-                    # files were built. If they're, print a summary and=0D
-                    # return 0 at the end of this function=0D
-                    #=0D
-                    try:=0D
-                        subprocess.run(latex_cmd + [entry.path],=0D
-                                       cwd=3Dfrom_dir, check=3DTrue)=0D
-                    except subprocess.CalledProcessError:=0D
-                        pass=0D
+        # n_jobs is either an integer or "auto". Only use it if it is a nu=
mber=0D
+        if self.n_jobs:=0D
+            try:=0D
+                n_jobs =3D int(self.n_jobs)=0D
+            except ValueError:=0D
+                pass=0D
 =0D
-                    pdf_name =3D name + ".pdf"=0D
-                    pdf_from =3D os.path.join(from_dir, pdf_name)=0D
-                    pdf_to =3D os.path.join(pdf_dir, pdf_name)=0D
+        #=0D
+        # When using make, jobserver.claim is the number of jobs that were=
=0D
+        # used with "-j" and that aren't used by other make targets=0D
+        #=0D
+        with JobserverExec() as jobserver:=0D
+            n_jobs =3D 1=0D
 =0D
-                    if os.path.exists(pdf_from):=0D
-                        os.rename(pdf_from, pdf_to)=0D
-                        builds[name] =3D os.path.relpath(pdf_to, self.buil=
ddir)=0D
-                    else:=0D
-                        builds[name] =3D "FAILED"=0D
-                        build_failed =3D True=0D
+            #=0D
+            # Handle the case when a parameter is passed via command line,=
=0D
+            # using it as default, if jobserver doesn't claim anything=0D
+            #=0D
+            if self.n_jobs:=0D
+                try:=0D
+                    n_jobs =3D int(self.n_jobs)=0D
+                except ValueError:=0D
+                    pass=0D
 =0D
-                    name =3D entry.name.removesuffix(".tex")=0D
-                    max_len =3D max(max_len, len(name))=0D
+            if jobserver.claim:=0D
+                n_jobs =3D jobserver.claim=0D
 =0D
-            if not has_tex:=0D
-                name =3D os.path.basename(from_dir)=0D
-                max_len =3D max(max_len, len(name))=0D
-                builds[name] =3D "FAILED (no .tex)"=0D
-                build_failed =3D True=0D
+            builds, build_failed, max_len =3D self.pdf_parallel_build(tex_=
suffix,=0D
+                                                                    latex_=
cmd,=0D
+                                                                    tex_fi=
les,=0D
+                                                                    n_jobs=
)=0D
 =0D
         msg =3D "Summary"=0D
         msg +=3D "\n" + "=3D" * len(msg)=0D
-- =0D
2.51.0=0D
=0D

