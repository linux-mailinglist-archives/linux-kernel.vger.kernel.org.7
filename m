Return-Path: <linux-kernel+bounces-749914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AB8B154B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE77B17CE64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253DB237180;
	Tue, 29 Jul 2025 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJKo+Lsz"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B10221554
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753824899; cv=none; b=P7kNDsdWSxYbNibxyA/r7DdeOVsDr3eAD0FpoT0cHV/iShntVRgxJNv08NEI5ipBgEnqfQ6qUZp4lCq85d3iiGdDjoCeB4vGT9a1q/vu8dJ+pRO6LjDFdQkK70K6lm3SZLNmW1U6e76NZ/cpjnhNe49GIAwa7K0fClqNQdrkVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753824899; c=relaxed/simple;
	bh=hV8pNDtHEaZuH7Mi4bBOWtAgIplXFi9R/rVfvMjJlz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K24lpR0Iecx9QruERGpHS2N0aPxhp1K5tqUV/C3hIz7rhToyU9cF8XOU/2KImeExYKftOslP+RDbXRAujV7qRMAH8hTrUVGRKsAusL5aTVrjVIJDLdjRI7rpR1jd8fiWSImLwbeUbhT9wNuajGkEAdXxm5kk082LuXtXct72UhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cJKo+Lsz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31ecd1f0e71so3234220a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753824893; x=1754429693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVCLxnNX9ssCVFunVtRLzu94Pq3RrLWSiFarp50OMoI=;
        b=cJKo+Lsz7p1vFwK7fTCkV1yVurEXO5S9oeokVwd2MwrO8W348HV7hrT9t+3lJuI0gd
         fC3oXMLLE5uEtP98g8QLTUm7jh3moZB908xL12HfJL4oh00UR6U50nEF8vCKcqtnD3ID
         Wm4W+j9RgyVCZlIjzgT4KLZJneAdguywOQhUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753824893; x=1754429693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVCLxnNX9ssCVFunVtRLzu94Pq3RrLWSiFarp50OMoI=;
        b=pknfVmqA5ShdO8X8mdlLWiIwA2P+cYrTtJUrVqAkr3U9VW2c9voYlkwovCkiASPscO
         bXhd8OdKbLRkFML/7UEO1LDQiP7mURmw5aeyvNQRqwFDS9cvjMQoJXZ21OghbL9eY9C3
         QB8IJs1Tyh6lWtQkeTNvHGz1AWrPtGY+qxGEs5+CBNMQgnBdza/kABifStWplOyudS4C
         sZBBqdcoiNZ02fJYHpr4V/ixx7mJjUTCMj5Piq1M86Z4pldJndLPkCkyOt3aLllSM6z8
         5DY9JGmNBMyXZ+wiTsLR4SZL5pPZGDjCVfHR1gi8iEhibubmMlPu10b1lHEFhU/Gttrj
         aU9g==
X-Forwarded-Encrypted: i=1; AJvYcCWihQWj/fgLB8zjsR1nF6n3rN4uWfhapwl+xmSOif50Lc950tH8W6h3SYnb/t4gFxJtB+j21QgeSBnA1u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFSTfmjSKk4MfvxPK6BTbUsCzcrIjEd0hKQwtXNgWNwy9Q6vGi
	rR8NhHhhFFWwDldSuB5TYQncDJy68eUQi3B4VrZHBG10A6zvy1Jm+FLqxSDGz4ce4+YBKFJqtVV
	zT6g=
X-Gm-Gg: ASbGncspYcymHh4IAGWwBMQhtA0pXvo5DB/oGNLBsfVq7VpsecmT1pXT3Z7vP2kpuBc
	nXxT6NkiqTWglmB27s+bBnQuGmDZ/DnmkEa+BD9FOQMBnnCW7iUO20MQEs5yY2Rg7tsUYxIGuOJ
	NOEXcNCbXgtBhw+0jfm4rSe54bzGUfWzWxMOBTnvIFoYqoUsblXWP1PlUtNUKX8c3Eqb+7KQF/c
	CoK4JN9lUfFg2OUW7nxqxCsAJGir+HKG+n9MBrYTMEpE8mWg9UC9+i94+dqZyTxYMK7rbhKccYS
	AVkRv6TL7tDkuKkLcUiG2SSEMNnPpAWb3SZ3WActHRJ3POTmCz/0dhL9hrzF6hSV6RbJp6qz6A2
	Uyg02YLnaQm/XLZzRURrrV4vCWAvWfUHmUZHiy4AMF/aa8IB5AIM8OLU6Qy3qZA==
X-Google-Smtp-Source: AGHT+IEQ0TIsGqhjoFEuyCCiHnHSc0HVPXGtiGiFSoO6t8xPW4ak3QVLiEpZo+m5rMDKTaMFRkibDQ==
X-Received: by 2002:a17:90b:5623:b0:31c:23f2:d2ae with SMTP id 98e67ed59e1d1-31f5de41b29mr1398445a91.15.1753824893031;
        Tue, 29 Jul 2025 14:34:53 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f30dc9fd0sm1524122a91.1.2025.07.29.14.34.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 14:34:44 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31f314fe0aaso1366669a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:34:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAzFcgyegpt0EeZaiNCX4zKKvjCe3UQAgZIZBkyo17de7enIalDM76FtfF1aWHGvopVHrb0r7bQsOBU04=@vger.kernel.org
X-Received: by 2002:a17:90b:3948:b0:31f:3cfd:d334 with SMTP id
 98e67ed59e1d1-31f5de1f1f7mr1224460a91.4.1753824882727; Tue, 29 Jul 2025
 14:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729054435.1209156-1-me@brighamcampbell.com> <20250729054435.1209156-4-me@brighamcampbell.com>
In-Reply-To: <20250729054435.1209156-4-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 Jul 2025 14:34:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbTQRD+hbykD5DXGWKXsJ5+rEH6vWa4dsSMmxU+NKz2Q@mail.gmail.com>
X-Gm-Features: Ac12FXzeQrf6_M_2inD2z7AMl0MQ8EJWdRVuuxzGi0c9nlBwan7lOfCSMzDT35M
Message-ID: <CAD=FV=XbTQRD+hbykD5DXGWKXsJ5+rEH6vWa4dsSMmxU+NKz2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: novatek-nt35560: Clean up driver
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, linus.walleij@linaro.org, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 28, 2025 at 10:44=E2=80=AFPM Brigham Campbell
<me@brighamcampbell.com> wrote:
>
> Update driver to use the "multi" variants of MIPI functions which
> facilitate improved error handling and cleaner driver code.
>
> Remove information from a comment which was made obsolete by commit
> 994ea402c767 ("drm/panel: Rename Sony ACX424 to Novatek NT35560"), which
> determined that this driver supports the Novatek NT35560 panel
> controller.
>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt35560.c | 198 ++++++------------
>  1 file changed, 60 insertions(+), 138 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

