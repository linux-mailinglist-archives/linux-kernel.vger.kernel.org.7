Return-Path: <linux-kernel+bounces-813465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D0B545D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5867E17D64A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71711F4C9F;
	Fri, 12 Sep 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0WQMvCm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F6F2DC793;
	Fri, 12 Sep 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666804; cv=none; b=Bi6DIv45xJviRN9+UQk+UuT90Tzh9TAqN/49xG2zBk833RVanovrYk2RqQkvZcgEFycbdXJforf+7OQBMgeauz/djFxIDpUiHxEnW19i8AJoE7XYH26/J8iG73GGNygoO2wPyjo0nuNxSQjM0wj7ejLzbYxdHe20Bi+gHztCQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666804; c=relaxed/simple;
	bh=tB552EcC3dT+MWtH2KGQtr52pu/sx5gcFpmjxx+Sm2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyXalNKuPQGFFwvaMHkFAxrq/gSb+r/MqClDFmzStqRz9TrjUq+Dw3ZlnzgfEGBFxHA4kma8RAu3CC+0n9y10/ezqqHQkfiTj0hzeCpzI3NdEOBnXBNXpTjIQ0aHWWH4+jlgAvmp3JkJhIWFyhwaw97c+Vcs5/BaM2UtemEKMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0WQMvCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4461C4CEF4;
	Fri, 12 Sep 2025 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757666803;
	bh=tB552EcC3dT+MWtH2KGQtr52pu/sx5gcFpmjxx+Sm2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K0WQMvCmANFvkTj4XCidgSwyBgHSFZMr6PxortgBnNgxEajQhARfbs7pFywd+44+H
	 6D5jOdQPAKfSz6evhaWfXZpvx/ay635697622aaQCsVLaCTXYkgJbZgyQhDqrAKU5g
	 RRcoCVPcdukPjuaNmjjCRoh2X4s8JneiWfXN790heh+aASbNlZ7RFCeWolf0poIpMJ
	 vbCyALIZBKxy8+h/vcSINDa8HgoTRIuH4OaJfmvoLfzMh7kSy+gqp1RO41cUA2Tnk4
	 Ls26qG4mLIe66taBB7AvF0muBhT8407ceOPM2GDIM/qhklV5d5p9wFsRsieKqdeM7l
	 9HE2CTTitdQwQ==
Date: Fri, 12 Sep 2025 10:46:39 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/19] tools/docs: sphinx-build-wrapper: add support
 to run inside venv
Message-ID: <20250912104639.4781b638@foz.lan>
In-Reply-To: <b76575eab805884ee5227ae6f1aded505df4ec56@intel.com>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
	<2158cc4cf1f9bcf4c191f8031c1fb717cb989f7f.1756969623.git.mchehab+huawei@kernel.org>
	<b76575eab805884ee5227ae6f1aded505df4ec56@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 10 Sep 2025 13:51:40 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > Sometimes, it is desired to run Sphinx from a virtual environment.
> > Add a command line parameter to automatically build Sphinx from
> > such environment.  
> 
> Why?

In my case, to be able to test build with different Sphinx versions.
On some distros, only venv works.

> If you want Sphinx from a virtual environment, you enter the
> environment, and run the regular build, with sphinx-build from the PATH
> that points at the venv.

when you do that, ./scripts/spdxcheck.py breaks, affecting checkpatch.

> 
> We don't do this kind of extra magic for any other tools, I honestly
> don't understand why we'd do this for Sphinx. This just adds complexity
> for no good reason.

> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  tools/docs/sphinx-build-wrapper | 30 +++++++++++++++++++++++++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
> > index ea9f8e17b0bc..cf7b30bc40ff 100755
> > --- a/tools/docs/sphinx-build-wrapper
> > +++ b/tools/docs/sphinx-build-wrapper
> > @@ -63,6 +63,7 @@ from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
> >  #
> >  #  Some constants
> >  #
> > +VENV_DEFAULT = "sphinx_latest"
> >  MIN_PYTHON_VERSION = PythonVersion("3.7").version
> >  PAPER = ["", "a4", "letter"]
> >  
> > @@ -119,8 +120,9 @@ class SphinxBuilder:
> >  
> >          return path
> >  
> > -    def __init__(self, builddir, verbose=False, n_jobs=None):
> > +    def __init__(self, builddir, venv=None, verbose=False, n_jobs=None):
> >          """Initialize internal variables"""
> > +        self.venv = venv
> >          self.verbose = None
> >  
> >          #
> > @@ -195,6 +197,21 @@ class SphinxBuilder:
> >  
> >          self.env = os.environ.copy()
> >  
> > +        #
> > +        # If venv command line argument is specified, run Sphinx from venv
> > +        #
> > +        if venv:
> > +            bin_dir = os.path.join(venv, "bin")
> > +            if not os.path.isfile(os.path.join(bin_dir, "activate")):
> > +                sys.exit(f"Venv {venv} not found.")
> > +
> > +            # "activate" virtual env
> > +            self.env["PATH"] = bin_dir + ":" + self.env["PATH"]
> > +            self.env["VIRTUAL_ENV"] = venv
> > +            if "PYTHONHOME" in self.env:
> > +                del self.env["PYTHONHOME"]
> > +            print(f"Setting venv to {venv}")
> > +
> >      def run_sphinx(self, sphinx_build, build_args, *args, **pwargs):
> >          """
> >          Executes sphinx-build using current python3 command and setting
> > @@ -209,7 +226,10 @@ class SphinxBuilder:
> >  
> >              cmd = []
> >  
> > -            cmd.append(sys.executable)
> > +            if self.venv:
> > +                cmd.append("python")
> > +            else:
> > +                cmd.append(sys.executable)
> >  
> >              cmd.append(sphinx_build)
> >  
> > @@ -533,11 +553,15 @@ def main():
> >      parser.add_argument('-j', '--jobs', type=jobs_type,
> >                          help="Sets number of jobs to use with sphinx-build")
> >  
> > +    parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
> > +                        default=None,
> > +                        help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
> > +
> >      args = parser.parse_args()
> >  
> >      PythonVersion.check_python(MIN_PYTHON_VERSION)
> >  
> > -    builder = SphinxBuilder(builddir=args.builddir,
> > +    builder = SphinxBuilder(builddir=args.builddir, venv=args.venv,
> >                              verbose=args.verbose, n_jobs=args.jobs)
> >  
> >      builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,  
> 



Thanks,
Mauro

