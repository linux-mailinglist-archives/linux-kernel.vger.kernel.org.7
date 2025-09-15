Return-Path: <linux-kernel+bounces-816390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BAFB57334
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457A3188DE11
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF2B2ED15C;
	Mon, 15 Sep 2025 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asYBn+zG"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7F829D260
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925593; cv=none; b=fhsp6CDSRKyNhlhgrNVFadf0memhGpI1NHADUgyWHTqDNjill9eGCmTm1W4JY7wBi7llhRD1AQ4MGJ59/Vd1zTKI9G1+JTggl5GERsGVx9aMJYR2WpDAsRZrZzLzSKIEjXyMwxdee5zDTJOHaFrnUySCbqeCehyq0cZM2J1tzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925593; c=relaxed/simple;
	bh=Ja+DWURKVC/MhjrBt/JOedxNP3etC5XulOORUTF4wgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dv8tW6KzR0oAbjdSZTK0GcrxqbxpgXG2UsVhRuQI8NAZ/U4Bdxwbk5wu/TA6SzLNpAY/XofrgCXMd3Qt2+mqFom/ycZ4ac0qFrmh9vKT1kWtsswMsGIjcP9ZIHc30xpp+1Uv654OhUi81MHugl9sOdPkRmbhuOfBZY9iPxDVyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asYBn+zG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso3355586b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757925591; x=1758530391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jEX9XijT6dZdXfDNPrPyYoF9pF2to+I4KU0mZQv7Zoo=;
        b=asYBn+zGUNoQjOHi44jaWV5WqQDgUAPofDMhJ23uVkXSKfnYMy2UQ5dggH9hd97B+T
         0aS1+z9hLsoLpNYQSHOzN5ZbvSvk8gjbTOn8X+3ncfB38bVNa6djj5dq7KKOqPTRgR2n
         FvyDyrrCn6gj+MGuj1Bdihml88jR7nThjLtbftfF4Bzx3AHA0CjzyKcsE0I5zqMRILJA
         1i79KwkQMpqSentWGFPPS8SFNjoEw4m25+YcOinJ3A1K4/Gr7B1mWqpdZdnnOUYwH1jm
         GB8/nS0jTf/KDONuRr6XSzCeGovKAwo+5Xs7bULFki/q/wTQxbtosgJvFfl0Qib6qPfk
         dU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925591; x=1758530391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEX9XijT6dZdXfDNPrPyYoF9pF2to+I4KU0mZQv7Zoo=;
        b=df74UynrEZPqjyEZW7TO6ltS1Z9nOxKCSIWMsFLD1z0YEjCmG0jEW+5IiCz2unAB2f
         hKrdOHR5r1RWUY/CVXSncFamUaEC+1dROmD60dOmG1sC5FflFp6cL6tCEIWW8VpQ4e5+
         0VTvuBCcInuVcx8VxZ6J5TixXSrApwPKJH++ue6YI+nYEdXZHgVzlval7e7UEub2EYBm
         eRqFMoyQMzmnMDv/znvWikdXaakobOlvgoyK7HHiBWRFq3priC0bmimMEHe+qVh3+XDg
         7FwJqCld9iRDdyqnGp2hem3/uVIbxONrVXsow2u9mU+kfOOqbAYf+jhuMbgB6rD8H0zY
         nLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV5oEL8pcEZXyEfWdZ4PpVa2T/ftEH0q9jc+W2yUzV64TEfxtZmXDnI2Z7WcqORtPUHSWuhNpmx0koGKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJaPIeMZyKYOmdSt3OP6aTTjJRZj3NgkMSpJYvbae6mC9y1i6R
	YWfQqNu+1DK9wL2cywME5/X0RtEt+tr+Mhvi2Tst85mt9tCg5DXkaUEU/n8+MgKPNg4OlCqC0M7
	37LD0761YRTDmZqVIr5Gfe45QUrRvFr5ophg8l5LJ
X-Gm-Gg: ASbGncva3lArTNFwNxZL4auSvL9ATF1f56eoJOp2zVysNCguiG2CG8cu+4xOYIIROYl
	ToqWb0hqmC9hE8REcUZUvLJlR0a0669dExGex86BgJneEzYGgtlXcch63ubYWWl0D+ufU+0JLZR
	B9yFseJS9EF+NfrHkMw2f8gK67TSGjio5ktGbBPd6R0CyXO2LfuUdzqcLS2h7TJ9ROEKu1XIXUk
	gqO0V733vMBqvpGOR0GKBQu7X5zU6/1TLBlovW4DQ==
X-Google-Smtp-Source: AGHT+IFQWa1Lq5s3wHqivhZWy3fXCUWg+0nXwEU0qlOA4xFoXSjxKquMoaAEWKKfO/WgYI37H9Hf7stft0DUGFXxn+A=
X-Received: by 2002:a17:902:ebc5:b0:256:3dfa:1c98 with SMTP id
 d9443c01a7336-25d23e13e2emr141646225ad.11.1757925590740; Mon, 15 Sep 2025
 01:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905091301.2711705-1-verhaegen@google.com> <aL5t33Ztwse6HoQP@vaman>
In-Reply-To: <aL5t33Ztwse6HoQP@vaman>
From: George Verhaegen <verhaegen@google.com>
Date: Mon, 15 Sep 2025 09:39:23 +0100
X-Gm-Features: Ac12FXwunFCBoJSIg5TZc6taVzPDODNO9kbuJ_l3vtZMfjpWrOJmHmPUWle_GzA
Message-ID: <CAAntYmJbFo+PZGVamNYjOav03UrZ0i6a6fMiRdfTJ=LgsHiCZQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] ALSA: compress_offload: Add 64-bit safe timestamp API
To: Vinod Koul <vkoul@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Cezary Rojewski <cezary.rojewski@intel.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Srinivas Kandagatla <srini@kernel.org>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-arm-msm@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 06:47, Vinod Koul <vkoul@kernel.org> wrote:
> Please updated tinycompress changes with this once this is picked up by
> Takashi-san

For reference, link to pull request:
https://github.com/alsa-project/tinycompress/pull/29

Thanks,
  Joris (George)

