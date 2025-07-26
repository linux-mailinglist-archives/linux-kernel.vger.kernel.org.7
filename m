Return-Path: <linux-kernel+bounces-746681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237BEB12A05
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF414E1676
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C98F23FC42;
	Sat, 26 Jul 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtNu1I/U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4823E32E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753525589; cv=none; b=q67cQ1QE62ziCJ1e1D3gQoFC9h7o4PVqzDVZgTF0XHFOUSQ8VZ0iVfMRqYMP+nTV5SXPCeHPrFQZARrxAhvx+XvyFRJmWH+s8F1qybr47hzEZ+5iwNM/8kpL9plFW0xHQ9EBP4AntMdx9OlBzmqixCJRH4yUlY9eN6U20vdzdEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753525589; c=relaxed/simple;
	bh=mXm6wcwBc4Kd8D2LPcQhshcnfpgL/tU2/Tl8OI1xRhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2znAtYwi/oKb7mwYklQjylZi49MBp8J7CvFkUdFAIf2+c1HdJjNbbV1SlkYqfZbrOfKEInBuePcuwUmmd3C2ZRIUddfY1u1gOs7BTh1E4NPYZa6cA1KPT1sXihQY38tmVVeH4Rzqi0DAfNhKhCF83EL8zbGyQv1Hk8ZXERspvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtNu1I/U; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753525588; x=1785061588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mXm6wcwBc4Kd8D2LPcQhshcnfpgL/tU2/Tl8OI1xRhw=;
  b=JtNu1I/UTWqv2KA35ks1Wtw6C2kYEp1AQ00NOXh2Tw7P1WHvI3FdvaAr
   wBLh78KLLPZ/Upwlea3TFYvzgq2h47y7t0xYDcf7qKrHjIMJAivIHwnVs
   1NbNMoj3Wqtgt3EpkTOx8kQV1D2/P82NsM3n91fUfJKy2GTfUo6/x3LC+
   sKVjehMUrBr72y41RwaUzBX6F6pUjqPIkEJlFbZqDb9i1bIakQXiY7tKC
   7wCRjTxwkVvvrKt3TX001O1l3krw/of35k7J55bhdiFjMoY6TggI8Zff9
   X9vMgmXhpPeCKvUq6Io6LaG7ZQJEsbK/L3bsm4wAyQFck6GRyHl3JfV/y
   Q==;
X-CSE-ConnectionGUID: 7oDonvGgSX6HAMcLEY5giA==
X-CSE-MsgGUID: yF6rd0fuTNqugMyXTYEIBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="59497443"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59497443"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 03:26:28 -0700
X-CSE-ConnectionGUID: zpUvcUdoQXOjVxzv/rcSRA==
X-CSE-MsgGUID: AFp1f55pRKOvFvlm/dPC3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="185141884"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jul 2025 03:26:26 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufc6h-000LsA-2b;
	Sat, 26 Jul 2025 10:26:23 +0000
Date: Sat, 26 Jul 2025 18:26:16 +0800
From: kernel test robot <lkp@intel.com>
To: samiksha.palav27@gmail.com, gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, shdwcodr <samiksha.palav27@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: Add hardware acceleration for 16bpp
 imageblit
Message-ID: <202507261818.EFdmyMEX-lkp@intel.com>
References: <20250724105254.3926-2-samiksha.palav27@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724105254.3926-2-samiksha.palav27@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-linus]
[also build test ERROR on linus/master v6.16-rc7]
[cannot apply to staging/staging-testing staging/staging-next next-20250725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/samiksha-palav27-gmail-com/staging-sm750fb-Add-hardware-acceleration-for-16bpp-imageblit/20250724-185607
base:   staging/staging-linus
patch link:    https://lore.kernel.org/r/20250724105254.3926-2-samiksha.palav27%40gmail.com
patch subject: [PATCH] staging: sm750fb: Add hardware acceleration for 16bpp imageblit
config: sparc64-randconfig-001-20250725 (https://download.01.org/0day-ci/archive/20250726/202507261818.EFdmyMEX-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261818.EFdmyMEX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261818.EFdmyMEX-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/staging/sm750fb/sm750.c: In function 'lynxfb_ops_imageblit':
>> drivers/staging/sm750fb/sm750.c:252:14: error: invalid storage class for function 'write_pixel'
     static void write_pixel(struct fb_info *info, int x, int y, u32 color)
                 ^~~~~~~~~~~
   At top level:
>> drivers/staging/sm750fb/sm750.c:270:7: warning: 'sm750fb_imageblit' defined but not used [-Wunused-function]
     void sm750fb_imageblit(struct fb_info *info, const struct fb_image *image)
          ^~~~~~~~~~~~~~~~~


vim +/write_pixel +252 drivers/staging/sm750fb/sm750.c

   233	
   234	static void lynxfb_ops_imageblit(struct fb_info *info,
   235					 const struct fb_image *image)
   236	{
   237		unsigned int base, pitch, Bpp;
   238		unsigned int fgcol, bgcol;
   239		struct lynxfb_par *par;
   240		struct sm750_dev *sm750_dev;
   241	
   242		par = info->par;
   243		sm750_dev = par->dev;
   244		/*
   245		 * each time 2d function begin to work,below three variable always need
   246		 * be set, seems we can put them together in some place
   247		 */
   248		base = par->crtc.o_screen;
   249		pitch = info->fix.line_length;
   250		Bpp = info->var.bits_per_pixel >> 3;
   251	
 > 252		static void write_pixel(struct fb_info *info, int x, int y, u32 color)
   253	
   254		{
   255			u32 location;
   256			u8 *fb_ptr = (u8 *)info->screen_base;
   257	
   258			location = (y * info->fix.line_length) + (x * (info->var.bits_per_pixel / 8));
   259	
   260			if (info->var.bits_per_pixel == 16) {
   261				u16 c = ((color >> 8) & 0xF800) |
   262					((color >> 5) & 0x07E0) |
   263					((color >> 3) & 0x001F); // Convert 24-bit RGB to RGB565
   264				*((u16 *)(fb_ptr + location)) = c;
   265			} else if (info->var.bits_per_pixel == 32) {
   266				*((u32 *)(fb_ptr + location)) = color;
   267			}
   268		}
   269	
 > 270		void sm750fb_imageblit(struct fb_info *info, const struct fb_image *image)
   271	
   272		{
   273			/*
   274			 * TODO: Add hardware-accelerated support for more image depths
   275			 * Currently only 16-bit (RGB565) images are handled in fast path.
   276			 */
   277			if (image->depth != 16) {
   278				cfb_imageblit(info, image);
   279				return;
   280			}
   281	
   282			/* Accelerated rendering for 16-bit (RGB565) images */
   283			const u16 *src = (const u16 *)image->data;
   284	
   285			u32 fg_color = ((image->fg_color & 0xF800) << 8) |
   286				       ((image->fg_color & 0x07E0) << 5) |
   287				       ((image->fg_color & 0x001F) << 3); // RGB565 → RGB888
   288	
   289			for (int j = 0; j < image->height; j++) {
   290				for (int i = 0; i < image->width; i++) {
   291					u16 pixel = src[j * image->width + i];
   292	
   293					if (pixel) // Draw only non-zero (foreground) pixels
   294						write_pixel(info, image->dx + i, image->dy + j, fg_color);
   295				}
   296			}
   297		}
   298	
   299		if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
   300		    info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
   301			fgcol = ((u32 *)info->pseudo_palette)[image->fg_color];
   302			bgcol = ((u32 *)info->pseudo_palette)[image->bg_color];
   303		} else {
   304			fgcol = image->fg_color;
   305			bgcol = image->bg_color;
   306		}
   307	
   308		/*
   309		 * If not use spin_lock, system will die if user load driver
   310		 * and immediately unload driver frequently (dual)
   311		 * since they fb_count could change during the lifetime of
   312		 * this lock, we are holding it for all cases.
   313		 */
   314		spin_lock(&sm750_dev->slock);
   315	
   316		sm750_dev->accel.de_imageblit(&sm750_dev->accel,
   317					      image->data, image->width >> 3, 0,
   318					      base, pitch, Bpp,
   319					      image->dx, image->dy,
   320					      image->width, image->height,
   321					      fgcol, bgcol, HW_ROP2_COPY);
   322		spin_unlock(&sm750_dev->slock);
   323	}
   324	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

