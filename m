Return-Path: <linux-kernel+bounces-766667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97024B249BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AC23AE2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4622E54A3;
	Wed, 13 Aug 2025 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtD/OtLv"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513717B402;
	Wed, 13 Aug 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089160; cv=none; b=ayUWSHwe+E8KEahGmtVtUyxGNXnHKDfZ23oQ1jCJ5CYLCV1NmFWmE3HxTbAyutVpC+0KVkHceVQVm17FpUero9NyWiE0s6ieWWGvcvg+ZVG/MXLCvZemCG2m9qd7gxFS14fQBjoVC0Lx35jRs3lRfuVh/aMMipw0kFdV+5wME18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089160; c=relaxed/simple;
	bh=0M8pfTsIZmI0u0UzRO0+bhYvF+WzsBzbryTYBMghUMw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eA2gFJl9xxwn/nlNPyFoLQ8MCXCw4NfnkzI59qeZCKWZtJ99MdCu081QvnoEXkGa0n2TPs6KvCx/Xy+DIiciUdZWjM53pgiEijcTUUGZaNKGZ6IIAqXrNsNswfMlZXL8YtC4BnUtI7HBYqrxvJQOwoOGcxioRFb+Rbq/Q5pdcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtD/OtLv; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71a38e35674so46792067b3.3;
        Wed, 13 Aug 2025 05:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755089158; x=1755693958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GBx2z/vPe5D7yLRGcOgmPu0sG1tvZgwioNSTVBmyCXc=;
        b=HtD/OtLv2SLzGl9sAFUFC7ab/t3G1C3kXiPYaqkzuLn2YLOqMD7jGqOtNNPa50z9ih
         NnmDplDyHC0knxOQ+8DSzIRMfY6myVyyyQC0mFalxTC+zBCUPi3yxq1CKI37+O3yUg72
         Un5AYmsrItT+gO/OE3DgcH8+MseWm74IjkND2ZVMdZL8+Yxm8cTz4Sco8Bgk+Xt70xmN
         UlJFWhGpKh/5uslFoQzQexCcgN3lTATPGFGuw+6/Xyq+G5Uovore46kjuQgKKJkVeM6y
         pGlIDQD51mZ2ZHm6y++XwzmmMzWYtgMnRnC7CCFLdZz5gctI99GCmeiED5DgzJ3sY32F
         gM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755089158; x=1755693958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBx2z/vPe5D7yLRGcOgmPu0sG1tvZgwioNSTVBmyCXc=;
        b=d/aLin2KrNx3B+Ro3S2n2ejcu/Jcx8knG8+TnSm8rbWKPZSvfjG80NoSaP8FkzFohn
         NFq7pVrKYk2hfgBU1G/ZJVh1ln/FGSxxDjg15ltRwYKBNfXbBSf1mdKKEl8Rxxi0ghD1
         terfx1y4/VFHmt37C259EuIm5U/eBzQll/fXgCNzjEFP14dbgBhALKvegj5lrOVY+IOb
         iQurtPw6yJY6Rvx9MGxFWm+oakEE9YZKNgB7VNszkJCjhRGD3i2iEwrQAo777OSSK/Qw
         52i/ch0sXOposlczjrhYu174qe6vSFj/3FQZziO7e3oAshPVlV3d0ayGwGyA4plnymZX
         W4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuc1OflXndjjj5bfZPUQIFHrh8ONRgkCRZhmzxfGw7Y86bTYNqhLitNCjH2bZ/Aet9q1Ew8+kFPXoepeJi@vger.kernel.org, AJvYcCWW+0wEmCFmqljbgSHUSttqcFBUb4ol8HA6Ax1goiibVge5fqQO1LVJoqCUKepMSyOsYh5AvBFPevw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UBTgoYU9eudEDdKGL3kUX83E9YMrRAFwkmYL6JoX+qagH0C2
	PNh2LCYGwCILzAobMYumCPGX4VjZF4DaRQe+DKQhQIA51GnJwM8mrQMkzK7eRMcqvlWjjtJ9Lzh
	bdIGuEPhIhyhJK1PTxorKaPMFo9OLOC8=
X-Gm-Gg: ASbGnctepgHBc232f0jYmruFSTEBhPC7FXjEKQhdZQGdChSu3ZXopdbzStQsgcnhZel
	qDUhpauiLdJuW7ARgZWAgH4VIJqbBptv+ITxvpJKUBnEKDyvyNUCo9xqwxJwndcxG4gpxr2F3Kz
	V3qaJhnqIHbON2q34eaN5+by38Wbgq1zibqRy73b7mvJ1N07wYATfHvA8gWzjwSKIvL0qnbvuTX
	WskN05+yArOxzkoq6zo
X-Google-Smtp-Source: AGHT+IFlb2b5IpXDiSZlxeBMX/BwJrCLwgtfaQYOLWXdH0F8mJA9XX3eenuzROZh+lYybzGgpYYc1HC20ufGJM0eguU=
X-Received: by 2002:a05:690c:a89:b0:71c:1a46:48ee with SMTP id
 00721157ae682-71d4e55d7f7mr31514577b3.19.1755089158191; Wed, 13 Aug 2025
 05:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Wed, 13 Aug 2025 20:45:31 +0800
X-Gm-Features: Ac12FXxVFTmWjeaCKXuJpQigf5uI2hJOfZy2W_DZxfQBpi3w4N0rFs8UGZGkfOA
Message-ID: <CAD-N9QW7=frNYSJDhaUiggSF9p_v33R8BQ0t8vypWUCXO+pyZQ@mail.gmail.com>
Subject: Re: Docs/zh_CN: Translate networking docs to Simplified Chinese
To: wang.yaxin@zte.com.cn
Cc: Alex Shi <alexs@kernel.org>, YanTeng Si <si.yanteng@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, 
	fan.yu9@zte.com.cn, he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, 
	qiu.yutan@zte.com.cn, zhang.yunkai@zte.com.cn, sun.yuxi@zte.com.cn, 
	jiang.kun2@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 5:11=E2=80=AFPM <wang.yaxin@zte.com.cn> wrote:
>
> From: Wang Yaxin <wang.yaxin@zte.com.cn>
>
>
> translate networking docs to Simplified Chinese
>

There are several issues in the patchset:

1) The line spacing is weird. Each paragraph has an empty line below.
It seems non-text mode.
2) This patchset misses a cover letter: [PATCH 0/4] Docs/zh_CN:
Translate networking docs to Simplified Chinese. A little picky:
docs/zh_CN is more suitable.
3) Revise the subject as mentioned by Xu Xin.

Dongliang Mu

>
> Wang Yaxin (2):
>
>   Docs/zh_CN: Translate timestamping.rst to Simplified  Chinese
>
>   Docs/zh_CN: Translate skbuff.rst to Simplified  Chinese
>
> Sun yuxi (2):
>
>   Docs/zh_CN: Translate generic-hdlc.rst to Simplified  Chinese
>
>   Docs/zh_CN: Translate mptcp-sysctl.rst to Simplified  Chinese
>
>
>  .../zh_CN/networking/generic-hdlc.rst         | 176 +++++
>
>  .../translations/zh_CN/networking/index.rst   |   8 +-
>
>  .../zh_CN/networking/mptcp-sysctl.rst         | 139 ++++
>
>  .../translations/zh_CN/networking/skbuff.rst  |  44 ++
>
>  .../zh_CN/networking/timestamping.rst         | 674 ++++++++++++++++++
>
>  5 files changed, 1037 insertions(+), 4 deletions(-)
>
>  create mode 100644 Documentation/translations/zh_CN/networking/generic-h=
dlc.rst
>
>  create mode 100644 Documentation/translations/zh_CN/networking/mptcp-sys=
ctl.rst
>
>  create mode 100644 Documentation/translations/zh_CN/networking/skbuff.rs=
t
>
>  create mode 100644 Documentation/translations/zh_CN/networking/timestamp=
ing.rst
>
>
> --
>
> 2.25.1

