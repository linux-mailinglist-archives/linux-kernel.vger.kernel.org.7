Return-Path: <linux-kernel+bounces-894866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0C7C4C468
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A5E18C2532
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2FB2FF673;
	Tue, 11 Nov 2025 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eO60w1ga"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E12EA156
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848526; cv=none; b=gXIcVGCCcRWy5Ss7v7V1mQcQU5FyN1O0JZGMFXNYjoAkLS+aR6kME9evS7jGckmCAZqQKL/9rKXFGgwtcWy7o+sQ/cBIQUG1n3SpcNUzq9YC2DuC09HspS94yP/0dZKIIplhb5/nZjx4WLqnzxQYzGWPiqrcJUPCVrWhNyVLuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848526; c=relaxed/simple;
	bh=e5xzHBdFbmW0XwOUR4XN/Edk4I4Zj1jSK1DHU7z74us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaClU7oCsBG9QxEUawj8UUbtYKI6ILzPYPCVraQHKMR9qv7L5CyBdI26NlCvh+thwPR62XWzAAetTjhVNAbEm9k5XlqfdaS3zrKWburthGaIQsZZCg5vJt8wawf3I3GRzSKalFnAL/67YSN80wyimFghdJMynG6PFpIJvfDw6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eO60w1ga; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29844c68068so1778645ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762848523; x=1763453323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0w05K6KxFo07worIjxTlWcgaX/lcLwwSdDEeFRVch6g=;
        b=eO60w1gaJ+K2zEQpiYSYxl5NHTKgGX7UDr1tcE1JEpXD52hn8nwKQkjhpXrZ5j7e+f
         EeeN22XwN655jqnfUIUex//h7wnGg3jPNNOzAT8WFgBXNQX1UplqYHhNlN1tkwVCXn5V
         gBWl5GtK+/aiaKXOsn6a9KSSHl+ehjnmtpRCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762848523; x=1763453323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0w05K6KxFo07worIjxTlWcgaX/lcLwwSdDEeFRVch6g=;
        b=S/Xquu4Y7HTdWIRPqI+/NOcGGfDB/oQXdcmUFDAE1Ud6mxcDJg+UIeQsZaTSes94pC
         BNCSxc78SM3yc3N6KUEBlGCuee7aC7fU7NsxBNUxYHhpK9C6GlyzgVVVvEi/2/h+e0aI
         CJNc9DBbe7pnCzTOPgB+WiCUaOoElT56uEG6+NBnUmA9Wm7mRdPPzvV3svvicafGDit7
         ugs1pTJ+A/mqU1zkQ8nV2gtK9rZAnUnhzD184ozY0YbziDn52m8ZQSM4YT/uBe+TURn0
         ZpPnh0r1mQ7Gq/qcc4C5otZ+h7OzOMyRLsXE6JcgyyM0wo/X1e1wZOOPGEwA/ImcUoVV
         Gxcg==
X-Forwarded-Encrypted: i=1; AJvYcCWVqPQjJDgSC0y4/xP3HVasNuxFFgZgakrnImjmphfZ3cikVO1zaFRlvwdep8G5wEuYIWMpnvtfNYEqSIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQanso4A6v83YcK9aOEpTnKRV7/8B9oYS4/Nl2WP+CNKoNUXr
	kJdri6hfzk13XzPPyFDTqL8H7mEfbitaaKCQbsj2gA4pRZgjTNjKByTIi1dapISkfQ==
X-Gm-Gg: ASbGncuBaxyD0YtN3eiHccdzbRfMxl+d8TObRrTHGb4dKn+OBcsGwwOVskQadiOPb1V
	Qn+5JS8eLKim37cCjMWWghHTynlwuNQFTyIVelRU9vKwWYNU1YAhCXeCsMmklbmkpjqLdJ6/JOF
	Z8zoWLCLPlA2sjel9MI84b3a1QO+Ec136vettwdD9jxnOOyQy9LQ5sJzPyHdP0k+aDzEKyu/SCD
	QjAVbnJ2gysrARfyZhBpSSuj4LvySuBTTQzcXWHObBmXp05mgkq8CBNgOTeQGAgIk1ey3P0uZih
	GDHTpw0JZafqdJ9lYnoRJzESJ6R2+/d17v8FflVaPxlXheXSIS19rRI4gxyNMx9sVXc5dya384i
	P19odSzIURgAZ59L//irq56ogKcHvRXsw1pFzgNek40YZjZdkCuD/jL1RQ8m1fCX1W9Cty36Ea9
	OpIobA
X-Google-Smtp-Source: AGHT+IHC6xuDhDXvZKC9hTiDPjxDoSsReKjYtkLbxL1ziXkP+RR6tEjoFAFy33iKv0lQXU9dzXWwTw==
X-Received: by 2002:a17:903:2c06:b0:295:62d:503c with SMTP id d9443c01a7336-297e5627aecmr142808835ad.16.1762848523256;
        Tue, 11 Nov 2025 00:08:43 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:4557:54b2:676a:c304])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca4262sm173807695ad.86.2025.11.11.00.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 00:08:42 -0800 (PST)
Date: Tue, 11 Nov 2025 17:08:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Alex Deucher <alexander.deucher@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Matthew Brost <matthew.brost@intel.com>, Hans Verkuil <hverkuil@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Vitaly Lifshits <vitaly.lifshits@intel.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>, 
	Sagi Maimon <maimon.sagi@gmail.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Karan Tilak Kumar <kartilak@cisco.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, 
	Max Kellermann <max.kellermann@ionos.com>, Takashi Iwai <tiwai@suse.de>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Gustavo Padovan <gustavo@padovan.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rodolfo Giometti <giometti@enneenne.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Richard Cochran <richardcochran@gmail.com>, 
	Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Satish Kharat <satishkh@cisco.com>, 
	Sesidhar Baddela <sebaddel@cisco.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 12/23] ipmi: Switch to use %ptSp
Message-ID: <pvjnjwm25ogu7khrpg5ttxylwnxazwxxb4jpvxhw7ysvqzkkpa@ucekjrrppaqm>
References: <20251110184727.666591-1-andriy.shevchenko@linux.intel.com>
 <20251110184727.666591-13-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110184727.666591-13-andriy.shevchenko@linux.intel.com>

On (25/11/10 19:40), Andy Shevchenko wrote:
[..]
> +	dev_dbg(smi_info->io.dev, "**%s: %ptSp\n", msg, &t);

Strictly speaking, this is not exactly equivalent to %lld.%9.9ld
or %lld.%6.6ld but I don't know if that's of any importance.


