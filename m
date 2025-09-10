Return-Path: <linux-kernel+bounces-810005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8760B51481
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96663B4096
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730F03115A2;
	Wed, 10 Sep 2025 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiIfSLJh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628E2C0273;
	Wed, 10 Sep 2025 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501508; cv=none; b=H0Pvn5mlLw0NEiyq8otp0bSNkaVNTi+IxGZA5zsOQ+A0fVQrVKQ5LOlajdoPYPOFfNZmMgD+Y7BZex9YBQFyS5EweRyUDtUvBtbPiB2NX/kviiGrZOqhc8/SN4pg7Mx81XJ/vVS14jqXhMwrsjd4+6Su0JnBdoKX1wn839iwLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501508; c=relaxed/simple;
	bh=pbWIW0JQjGaypFFKZ4PKMn++HCjHKj14Tq0tM1WzmXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dp/zDNB7NXcjudWkqzPZj80xFnvrui2XhFQv8JdhBV5w1nXdMgGBPANUHwS8sGeyPMTbp/49791APJcUGyCFq7dA4++ygSGM2UsZ2r7LAkva5Il6u0a9ozC9ju7x6oY/X/JyCIljgPr9kvnc7YYTNwCxXbzhSJZcZRmUb+MvvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AiIfSLJh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757501507; x=1789037507;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pbWIW0JQjGaypFFKZ4PKMn++HCjHKj14Tq0tM1WzmXY=;
  b=AiIfSLJhg/8uCRYEGP5LW0x7Tp6t8Z9a+dosGpMR2yViyMobaKUl7+hl
   z4EQhp+L8yhwY9RC3ByTeD8kkMQHX9KYmsskseupACTzIEENBAUuJDZAa
   VBNRTRxFQ0/+IVTNyhXARciihWg+bqKtdKOASPmH8aKsJSczKB0jq5L4j
   ElX0gLbD4CFKTB7qXvkBZz0Viwhky0Bl17dv6yPgwFq+mIAp4YRse5jxP
   kWxg/cT+0VVimIEzlrh9yaMJS7+bONmos39nrVMtj4sBpge4TBTEerLUJ
   OjI1IF2sO8MZLPKsJyhCJ0pzhGcwkndA8f+ygCnks6p3ODp+8Y1hVV4k4
   w==;
X-CSE-ConnectionGUID: ZX8sEStXT3KByYsGLpHOsA==
X-CSE-MsgGUID: LstYi1ucQ4GFMnas1rCm8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59914426"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="59914426"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 03:51:46 -0700
X-CSE-ConnectionGUID: iat/FCiUSgKykCH4qJRZkA==
X-CSE-MsgGUID: PLdwOrdERYOcH/A84GSv4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="172647774"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.72])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 03:51:44 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/19] tools/docs: sphinx-build-wrapper: add support
 to run inside venv
In-Reply-To: <2158cc4cf1f9bcf4c191f8031c1fb717cb989f7f.1756969623.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <2158cc4cf1f9bcf4c191f8031c1fb717cb989f7f.1756969623.git.mchehab+huawei@kernel.org>
Date: Wed, 10 Sep 2025 13:51:40 +0300
Message-ID: <b76575eab805884ee5227ae6f1aded505df4ec56@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> Sometimes, it is desired to run Sphinx from a virtual environment.
> Add a command line parameter to automatically build Sphinx from
> such environment.

Why?

If you want Sphinx from a virtual environment, you enter the
environment, and run the regular build, with sphinx-build from the PATH
that points at the venv.

We don't do this kind of extra magic for any other tools, I honestly
don't understand why we'd do this for Sphinx. This just adds complexity
for no good reason.

BR,
Jani.

>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tools/docs/sphinx-build-wrapper | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
> index ea9f8e17b0bc..cf7b30bc40ff 100755
> --- a/tools/docs/sphinx-build-wrapper
> +++ b/tools/docs/sphinx-build-wrapper
> @@ -63,6 +63,7 @@ from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
>  #
>  #  Some constants
>  #
> +VENV_DEFAULT = "sphinx_latest"
>  MIN_PYTHON_VERSION = PythonVersion("3.7").version
>  PAPER = ["", "a4", "letter"]
>  
> @@ -119,8 +120,9 @@ class SphinxBuilder:
>  
>          return path
>  
> -    def __init__(self, builddir, verbose=False, n_jobs=None):
> +    def __init__(self, builddir, venv=None, verbose=False, n_jobs=None):
>          """Initialize internal variables"""
> +        self.venv = venv
>          self.verbose = None
>  
>          #
> @@ -195,6 +197,21 @@ class SphinxBuilder:
>  
>          self.env = os.environ.copy()
>  
> +        #
> +        # If venv command line argument is specified, run Sphinx from venv
> +        #
> +        if venv:
> +            bin_dir = os.path.join(venv, "bin")
> +            if not os.path.isfile(os.path.join(bin_dir, "activate")):
> +                sys.exit(f"Venv {venv} not found.")
> +
> +            # "activate" virtual env
> +            self.env["PATH"] = bin_dir + ":" + self.env["PATH"]
> +            self.env["VIRTUAL_ENV"] = venv
> +            if "PYTHONHOME" in self.env:
> +                del self.env["PYTHONHOME"]
> +            print(f"Setting venv to {venv}")
> +
>      def run_sphinx(self, sphinx_build, build_args, *args, **pwargs):
>          """
>          Executes sphinx-build using current python3 command and setting
> @@ -209,7 +226,10 @@ class SphinxBuilder:
>  
>              cmd = []
>  
> -            cmd.append(sys.executable)
> +            if self.venv:
> +                cmd.append("python")
> +            else:
> +                cmd.append(sys.executable)
>  
>              cmd.append(sphinx_build)
>  
> @@ -533,11 +553,15 @@ def main():
>      parser.add_argument('-j', '--jobs', type=jobs_type,
>                          help="Sets number of jobs to use with sphinx-build")
>  
> +    parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
> +                        default=None,
> +                        help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
> +
>      args = parser.parse_args()
>  
>      PythonVersion.check_python(MIN_PYTHON_VERSION)
>  
> -    builder = SphinxBuilder(builddir=args.builddir,
> +    builder = SphinxBuilder(builddir=args.builddir, venv=args.venv,
>                              verbose=args.verbose, n_jobs=args.jobs)
>  
>      builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,

-- 
Jani Nikula, Intel

