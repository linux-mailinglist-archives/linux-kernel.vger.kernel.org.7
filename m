Return-Path: <linux-kernel+bounces-889731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1FBC3E5A7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C8B3ACF65
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414AB2E7F21;
	Fri,  7 Nov 2025 03:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVgaffeO"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487516132F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486502; cv=none; b=qcS/3IjvYCiiVtQnEAUKTmIat2Hy/ACqNkWpWB+SYOK/gfn+tfLD7ciKAIF1OPdUmZ6ojvZeHQ3TtmPprFd2l8oylv3MCYCx3CBHt63npgDPRM78mF1fdlMRIdQMrO4A13VHigYTq+GCq1jctOAh5UnrzC4q08fb6wo48Z8z/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486502; c=relaxed/simple;
	bh=/sdZ8+zzSN4+VevI0KHO+cKwje7e1ceK2OpOYkJQVIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8YQHHvFBgE9fQXCAtcl0e36AnJHL9w5A54NljlV0bMfistJLv3Uogfaz1avIy2M6iJFfNqEUDuUrW/Z3JtemWjHpoLVJL3QMBCdUi1+qK0YU/el+eyTD/SQDop11XJwGYbiKodKw01elWIsI1sBsvJsy8PfBB3fhPo4mZ0lfAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVgaffeO; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-786a8eeb047so3051087b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 19:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762486500; x=1763091300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sdZ8+zzSN4+VevI0KHO+cKwje7e1ceK2OpOYkJQVIM=;
        b=hVgaffeOwm2jWKVawg5d65K8HRPxDR8c1ZpEb7OgWxQ6NeLAVX64e66pzS6RlJ09dG
         NK0OW2eG/H8fpNitUyQuJu9plu0NdP/Os8pYFk7ZWgz+3cYX0vtOCOoFe3tX8fZCQpsA
         gdS6eRDsv3f1Hrp6Twl3vFbs5LLkqlWE5C1OkPLhBT7VBKjaYtDf4sI2k7X4XDRVwJE3
         G0WUL5o2HrLFjWj2nwoqLjSBAN8H9lpeW1zgbqzD9qbOyr1YwJFi0ppi4O4tetx7vOrF
         gF7h1mG/m7qks+2TZCvEp3Y0yRuR+zt2P3nX+8Zc1dC5FtBvj8+GI3QQ1ZFWqkL12raB
         1/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762486500; x=1763091300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/sdZ8+zzSN4+VevI0KHO+cKwje7e1ceK2OpOYkJQVIM=;
        b=HKMceLjAm+21+7c2lyKEPdU+q4sRLeIOr4lCDM8MmsGOv3/EK0+Yo+a4c5ld6IogaA
         gGAt7H4NNxelYjBn9EqMqTAwTRQKUyj9j1HEvsLl3PblM9WMN5MIOy6rVUy7Q6c8cfom
         GL1h7yerZvXJfFyZ0T0bwofLN//hM2I+T1Jz31lLF6vxa/uOAlVfTdjFYGs1QqJBRqRX
         ehhxnwO08fxWQ1DJU8vwroTEyDyJSktpqRZSIuGkSlo3c3LOw5vZlN+dibLYcF6Q9fic
         W5zQ+JXhZX25r04IDay8xjavySxYYKSA3QIeTivnx3QrOYVDWvt0ihX4DNUQehqepOQc
         VnuA==
X-Forwarded-Encrypted: i=1; AJvYcCUqmh5mOnJbdT60KEPpyVIHB1rX1oeG7cNdcAsh56kp5RT0u2ROXG31hG4j86SwAHdF4dLbm5hB60ervIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ea81eKHUAHvMWklz3m6teEl0DM6yrvKCpMvWKLPsuIqNfS7K
	Jz2/WMYDTaVeCsokWH1c/qptlfzdtrEcoWiW+kJjJIqex+Rw4Qg6Xc2r/UFIkEQfQDX/m0dQ0k8
	gvTzbrfPdmUZHvtKETJwiVgaMz7GcImo=
X-Gm-Gg: ASbGncspbVbW0VE6vhQUGhQQjn5rV469p/qPYbwfx/vzvqoOWY+VJydTy/dw7dWcpii
	H76aJVbMMxqZcljIEvPPwqkAKZOgGFbm4g4PKiPOhm44T9SlW017ni6ZmCutQpuNhcnd0EYypZ6
	kySs910sM1qaglX/iPu0myGrHfEYyTfvsPcKptNuEsrsE3rT0kTaZPBDmvLBIlFbNuqwxcXk+fs
	Ro+BSTrNhYnw8CGzUgvbDcVCp0y675laDHljPnMvIg/w0ICBWYyf+LGVNgO6O0OlDhQMs5gsdFP
	Esh11dS9kePo0INPX2lq3oCngOPz
X-Google-Smtp-Source: AGHT+IGDDqqgBqEgNOx4AELZAJ4xLLz45gA1UT45FyOO8v0dFg5xdJ6oOobqThWQoYeziLebEVo9RMmVybURSqYFTCM=
X-Received: by 2002:a05:690c:48c7:b0:786:61c6:7e5e with SMTP id
 00721157ae682-787c53ab9bcmr16461667b3.44.1762486500242; Thu, 06 Nov 2025
 19:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103031501.404141-1-dqfext@gmail.com> <d9b8ec8a-f541-4356-8c42-e29adced59c0@redhat.com>
In-Reply-To: <d9b8ec8a-f541-4356-8c42-e29adced59c0@redhat.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 7 Nov 2025 11:34:47 +0800
X-Gm-Features: AWmQ_bkkdncyWIw-Q3XtM-gpdPTe01VHbfYOl_wXWnzhLVqHYoEvskEhg06aKs0
Message-ID: <CALW65jbNbnDJkHA5imp6OR4MST7=G1XMQ3+ddQ38YuQThuKMLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ppp: enable TX scatter-gather
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 10:19=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
> Instead of dynamically changing the features, what about always exposing
> SG and FRAGLIST and linearize the skb as need for compression's sake?

I was thinking the same thing. But then we also need to linearize the
skb at PPPoTTY drivers such as ppp_synctty.c

