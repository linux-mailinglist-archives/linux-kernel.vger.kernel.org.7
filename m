Return-Path: <linux-kernel+bounces-760110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE80B1E688
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25D91AA78DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F0273D6C;
	Fri,  8 Aug 2025 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOku1agH"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E223C38C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754649453; cv=none; b=jW+JDW4xV1WtvVmkHcsjRHb8uReEab+bbQ1SVUWt/gU704a4WFO8+H+wKqzPGUFHrYtGGDHpO2ipFu4m8ZvbktDhHvsWcmYcM/HX68Dsvb472Q4ouUyDgzhetobxqn2E6hfS8/JAIC4ZpfV1nX3i/Lx0sVngmygopmQIL9dTNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754649453; c=relaxed/simple;
	bh=LlgSNxTwWrMNST7nzn55bHW5wW6rBXYYm5dJqlOLHEE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmNieVxdhIn9X7Jcjp5ovz0jgsC1LJGWOow/yuM2pw04AjJ39fkpVQpPgvvfDvHsdsO+Gr0fy9Wh6wfI5Z5SUHR8/mS9UuhS2ZOcbreyhhXK2c8aEf8RVFdZP74l2kxUJsIf6Jrt2exr6UgN//MYa6JsufCIShCiSxP4NwkBZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOku1agH; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3325cb38a78so17741551fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754649449; x=1755254249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tivFsmlGRlUC+/lbvStJvCaC7HPoVZahlLXTN48EL6E=;
        b=HOku1agH3fz89RZG/l8RpXz2QKU9mVJwHzzb0+cA1kzzCUTjoz5O56l8E7fNm7+fS9
         d7g9TGAmiaTR97pxznLAbSaObFT6Mb59mDdAgbkFy/kv54hrhRnsG1h+krP0E4w3s1IR
         P0zcRBZr01xcKigiKCoCrTifWYVG34e0GyPAdw82hv2okd+8qC/TUOqiwSKhjsm419Ch
         l3p8wzEnA/fye1F2rJnXWLkDeFEbE1pl6wo/Gyr0EOIpbHyZnUzTLKn4GW5qVHIxZkOZ
         9WIVY9Fjzt4Zo5VtBYfn7EC0XteBe4q3RPNSP5MVGDpJXWamNT7ENdHWsDLDOsQik2+E
         WoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754649449; x=1755254249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tivFsmlGRlUC+/lbvStJvCaC7HPoVZahlLXTN48EL6E=;
        b=wEtfhAwHouae2lMP3W0HxIKTrYy8jr88BjpOohM3dVzw/0AQBhTOaMWp3b3EROZvcX
         4uKVQ7yBa1OuAUnm56Jne3v9NahXiYbTn0BErfQdUWa7YeZ+x2k4KoYhoifiS1XqP4b3
         ny8MnV88UaXcwViRwVgNDcxP8gVq53xHTELM78H2YbvNuBfBwtKZs+PYNg6iaJHKjiK1
         lxH2oy2x47oF95UVWudrlV/nx/f73xIQF4W7rR7s5qZNNSXJdXxrtvEASkS7NMbR+l29
         BDncJTZPzrw+rqGFyfKDjh4UUx6h3rXXSpuYwQjFB0FuNmW6Jukd1PcldhQM8IUmmUTY
         KO/g==
X-Forwarded-Encrypted: i=1; AJvYcCWRzmyHgpIuFDSEDpRQOoNjhIKZWqLJVsWQNW4rfDWRP9WWNhHIuUcptwKPL3xSc7Gq0c8QQ55D4jSZm3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/pTZ/8N2VKju3OQyf4MMFVb4oUTLeGo0LwX5iIqO7krPQmPYm
	vcbfhVm+oiP/lIEofE6XOkxEq3uyEdHStmvmF22h5tyi4XdR6/AggQKJ
X-Gm-Gg: ASbGncsCwi/LkpelBvfi8voFECcEsSQhYI8sl33SXuqPWPSaKEUefGp4WCukOShwDMU
	5KFHIuRqTyDnzVotjm7Aq3omyW8Wwh/iV9+1srVXKlMokoafB5MrBZ13CA03/W8f5vfzlYwQaTg
	YGCaxo4dTpPDDbrtHf4aC6pyyYZT3cJ9bcLCac3VCpzqto3YQTDYqVEhbzxGoKoOXsRz4q1yK+F
	SnClXc3SoRzG5fq0fSeBbECUMmLdnxk5g0TRZaSjKeLcEcu0f1aoAB5oUWZX4p8jf7kmIzmYP9N
	6b5aS72tw/tbV9c8UAwzhVmcIx5WF5MYhBCtmWKO//VRCJplzQAeRXZqnn2r6G9L0MtBJDassDM
	OPIBl9e3LTNDXK7gyJxf7HVFPyPWJORBchBlvFYmmpVVV6TcIAg==
X-Google-Smtp-Source: AGHT+IGNPK/qZH+sTZpLkeVRCl0hK0nwxTZO2ywKJOBNHZUofU093y94ClyRD93Q0Qu6fX0gT++vdA==
X-Received: by 2002:a05:6512:4021:b0:553:a30b:ee04 with SMTP id 2adb3069b0e04-55cc00ea59fmr619925e87.14.1754649448954;
        Fri, 08 Aug 2025 03:37:28 -0700 (PDT)
Received: from pc636 (host-90-233-217-11.mobileonline.telia.com. [90.233.217.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3327sm2957802e87.127.2025.08.08.03.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:37:28 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Aug 2025 12:37:26 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] mm/vmalloc: Defer freeing partly initialized
 vm_struct
Message-ID: <aJXTZv5axtX08qnT@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-7-urezki@gmail.com>
 <aJSNDcMxE5BVl6or@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJSNDcMxE5BVl6or@tiehlicka>

On Thu, Aug 07, 2025 at 01:25:01PM +0200, Michal Hocko wrote:
> On Thu 07-08-25 09:58:08, Uladzislau Rezki wrote:
> > __vmalloc_area_node() may call free_vmap_area() or vfree() on
> > error paths, both of which can sleep. This becomes problematic
> > if the function is invoked from an atomic context, such as when
> > GFP_ATOMIC or GFP_NOWAIT is passed via gfp_mask.
> > 
> > To fix this, unify error paths and defer the cleanup of partly
> > initialized vm_struct objects to a workqueue. This ensures that
> > freeing happens in a process context and avoids invalid sleeps
> > in atomic regions.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> LGTM
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks!
> 
Thanks, applied Acked-by.

--
Uladzislau Rezki

