Return-Path: <linux-kernel+bounces-840695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A765BB500A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D627E3AEA61
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8A728507C;
	Thu,  2 Oct 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQLrq3wk"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFA527B34F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433258; cv=none; b=beDttfSTKfggD1u5cnj7EZ/QbB39LCw106heoOkEmAlSTaNN/I4FTUyBSDUNKUUAihqPEKQlhoJBJNXCk2cNKXoCnQPkeQpgh+WSkxX0yVk4NlmLSHpBVrZvsdTzbvf2AB4vLkKBS3CDUMS228RoZO+XtfJNqfcbkPRPJBo+ZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433258; c=relaxed/simple;
	bh=7gdu7OvnE/BdPY8a6TV/kIJlWQ8H1vqfFXLxfYXgYTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjYWV45QszMMkJBzpjDsfhCn5JjPt34yvfwuTnP0BLNKp/ZSwzyt834yovCUPFOWPJccNki2V99T3I9EyMGwLpLGJ+EqEJJ9domF/czxC7Bt+oSKoK5RDeXYQWTIHUlslxWBPP49+gI2g6+AkYYwTG03t7npSbBAalvSzfYLtTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQLrq3wk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so2068009b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759433256; x=1760038056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gdu7OvnE/BdPY8a6TV/kIJlWQ8H1vqfFXLxfYXgYTE=;
        b=hQLrq3wkS1w2Rst7kyCipFyYLo9UtOaIW63nK8eF3rG4SaClFLaBp3htRxxZv0yZ2S
         VcIL/gNs1k4mZ6hTsaLwKjBmuAu1QATVGzeUWM4r29vITo//dGXzY5KK9JPIaqUyxy3v
         lAcmdSQQswBG24pwyRqB4I8kqEv87jMBsdJ/FXks/Ic50py0BVx+b3RJGOH+qK6OFPox
         UW/AjWbCjJuyBQZAQ4KqwEGJE9JDGEvzgeZxL9i91YwSvucnYmepnll0zgCHei07BUj/
         zPoxWGtb/3FYrsC6j+NKmOMwgRg8T2ctNkNlFtvVieuaYvckp3j5zwgFOnYR0LpYCqIF
         F/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759433256; x=1760038056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gdu7OvnE/BdPY8a6TV/kIJlWQ8H1vqfFXLxfYXgYTE=;
        b=VRdQcsTyMBdcapu/ImzxxEso2JF++alv/LC8AdGWQDI2XRU1fyIaSks5PFon2NLaPl
         vpiiB8zokW37NvJ/tIiLPesPEMoiX245eCmLfmHbxxWC7UB9IgXpr0G/pLS1llqT1hQ/
         8Pt7EvAUk4c3vEfN7A1vVVWFg1D5YOQuyujOQVQ/nFH9V3khuuv/ATon2mWOld3SzF/1
         HYPLMuo1Dq19lG0a6b/RZl8tuOiUjrD0wxjeMXk+Q85ZFtDLLwJaRa1JgVtYn7W6iXkN
         CdlPWimBiJfEfN6LFF3M3U9rUUFCZmxDZBJ3UdfGl8UfS7Q7NW1F+zAJ0csE339x4GjX
         pBlA==
X-Forwarded-Encrypted: i=1; AJvYcCVClB7BBPbAvgNs4NfQl7beRgITdVCX1xzGMrNx7dR4KvwG6AyYN2STXgQnTf6nTzCsNJq8lkI4sazzyfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhFo33mh3AJ3VV7JUfVEF+6IC7oUYPZkcV4UkGUHG1YSwp2mr
	O1fXkJthXcR2jwALzgkE6ODronjpFPGR9fzXkJ3h+FyE6ZtTMSL8FIuQIYhusvxO4PoA0TBq6cl
	yZbqSKVgBPjtn00E2bJogUm6UcuzQR/Q=
X-Gm-Gg: ASbGncs4/3truoxffbx3Zv8ZiXT1mncje2VpPsJUxYnY0FrR3t+H+Qz2Zxrxcka0OYU
	dpmJJkdWi+4LIllwkh6DuzeazlxcHe1Hf/xAeiMYHyU1kFW+rvmgYtRZ249H/qIzT6fkaTeMmV8
	cMTv3Gp17JZ0TY7bgCmBYK0nvUtluIxPOrjk0qF6HMK7MD+7t4Yf1wcqFNS+5zftzn4pFsfD8mE
	2y8pmqce1H2Wl0+Hl/YaIAs4oZAZ4tYfBZycOrYYQADMe90wlI9f1CuPWID2ULzew==
X-Google-Smtp-Source: AGHT+IFHSMffOMVezAKpxf4xflxQPXHC/9PQfQy6n4Qt8MWkSRyYgaxLIW31hWZlX2OEAHUKUARWDCpbLDiVfKNbRN0=
X-Received: by 2002:a05:6a20:9389:b0:243:b62c:8a7d with SMTP id
 adf61e73a8af0-32b6175aafbmr953767637.0.1759433256415; Thu, 02 Oct 2025
 12:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002091448.11-1-alsp705@gmail.com>
In-Reply-To: <20251002091448.11-1-alsp705@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 2 Oct 2025 15:27:25 -0400
X-Gm-Features: AS18NWBJ2McJoGNd_MZw_c2oTY1FRFEzCn1b6DwesYnkNNElFy-oHlpyddLBacw
Message-ID: <CADvbK_frvOEC4-UbuYixCu2RbQuAOQLmTsi5-sGnO8_+ZSpT8A@mail.gmail.com>
Subject: Re: [PATCH] net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()
To: Alexandr Sapozhnkiov <alsp705@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 5:14=E2=80=AFAM Alexandr Sapozhnkiov <alsp705@gmail.=
com> wrote:
>
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
>
> If new_asoc->peer.adaptation_ind=3D0 and sctp_ulpevent_make_authkey=3D0
> and sctp_ulpevent_make_authkey() returns 0, then the variable
> ai_ev remains zero and the zero will be dereferenced
> in the sctp_ulpevent_free() function.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>

Fixes: 30f6ebf65bc4 ("sctp: add SCTP_AUTH_NO_AUTH type for
AUTHENTICATION_EVENT")

Acked-by: Xin Long <lucien.xin@gmail.com>

