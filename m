Return-Path: <linux-kernel+bounces-844792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5541CBC2C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F4A1896B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F17925522B;
	Tue,  7 Oct 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od8sTgHG"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B323D7EB
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873457; cv=none; b=kyLv6afH7+/wT1qcU5cFEt4PlmYTrl3y6v4onKWtzUGrNnA/I+jK9WnwMk9iLhtw4E9tH4bXhxZ4GsFNHj+ONN2nLswaSwQNUaB+W5x3t32uO7kce2wYlc5jelPWRe5D+CUHdUDD8iYK3nq00FiZ1ugMdGWoZIVpzuMMftCWbpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873457; c=relaxed/simple;
	bh=GeuADLD6S+jmWQoMtOXeNnY5ldQc5NiNSbQVRwG3JuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYMG1NgtS+NxqIT6xbp98llvsY3cCTs69em5T4P0Txr8zNqSWGcFC1x7LWMp/kYavJnqpkauKLpfyUYF2PA18jkiHNOZrEf5wCa5CF0S2lvKZveBDoR2Q6vRxZuC0qxta9cMQmvZSXDTHYJ9i07hteqZCIBZYw/lf3QTpU3+d2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od8sTgHG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso8075258e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759873454; x=1760478254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeuADLD6S+jmWQoMtOXeNnY5ldQc5NiNSbQVRwG3JuQ=;
        b=Od8sTgHGilfpYpKEmhX9ibpMXs1nKpGdigTeHhITF7TZsQOwwEt95suVE7eywMUZhv
         2dOnHZOJiEb3YhwfhQj4tJRUvkPLhj+K5L23TIG/hoWlLo7cOG9S/umOSlNc6potN2pk
         yDPecXpjLVvxhySter1Yo7kOJ4Hf6+cpf7Umo1m/B6Q5bBM5lmY3smVII+TA/Dko4vTZ
         rgCZaqTAyZsmMexOjtnMbVszjj68FETqmDnVfwIUmlOHCB3h/qgPFjJ1MoTliZv6wYvZ
         Pl+22YJwqepzoouChWptTxQHDRgqZSjkv9rrbCFtyKWGSxMhh/iw/RzZi91/BqpepHIP
         I8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873454; x=1760478254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeuADLD6S+jmWQoMtOXeNnY5ldQc5NiNSbQVRwG3JuQ=;
        b=myvE0JB4M/dyn8umqxCUgVy/tjM3UMtlJBDsXSFDepQWP+ryByYe9wq56+6OAGOQF5
         Lx8kozmR5UNwpb1oleQ9m3qbqhTLtWj0EcAqoYwSgsLAWrimWp+2xNFRc7wR4ZQTboPE
         bwiTX/EHVfCQsUX+i7qLz6+ErPp64il3Mbkxn0FthzDb7GFCMTUHpYJqX1jffS54rZHb
         bKkgY6QQshCBtTGeEiQEyFqCJ6SGiiqT4sChjIZ+1aVY6+OKL5xfR9pVxBB3TlncTqEI
         moa3JwLrIKdK6/sUVrdXgM9m8Hpiipm33o1siNJTsC6JvL4Edu6rb6LmUTLSeNw7KmbW
         3REQ==
X-Gm-Message-State: AOJu0Yx44lGo08W5NagUsW2X0qk5sW1jsKfD7zw9665OzEg7yPZXmrJQ
	k9DVM2g1GVFuoF80UU3aWoJ3FfO0X3ZAjgd0Qfso26xcf4AYzQ/FgpE6ij28cPESgqdkyx6TEJx
	iH03s7U3EBGhTCPSp3yJvoGw1WGLTXFuNRAXJ
X-Gm-Gg: ASbGnctzw7TscuZwjmA+qF5MO5KAiylmEJkdhEOqucRnrTa+QxmxYaD0aeTUlNAGt04
	0rE+Kl6xtAyVJGKfvDzUph888csQQNRezyJ3KLxlq1YXHdg5fwBuXZeJoqeF7DxBFUMU2THharW
	KdG2ivg0k5cm3LGGqeTNUL7jHmwocV7b3xJwBfviwcd+WGcRVV54e5V2zl7qAoV9bpyM7YgGAk3
	xbOqbpGTPjavbvGGU2L8RLk+A/iIouCDNQ0bvD0Dahm4aYz/a3Xf+vi/EB5igfP2rw9cfuu+Q==
X-Google-Smtp-Source: AGHT+IE/hkNdFAeCa0Hg+a4ZgeR2mvD/885sGxDqRHbpl2YwDlPNuJYFErVORLY8MNPSTFbtbJVlgq+1wkcZ/yPCTxo=
X-Received: by 2002:a05:6512:3090:b0:571:1bdc:14d9 with SMTP id
 2adb3069b0e04-5906d8b204bmr357039e87.24.1759873453358; Tue, 07 Oct 2025
 14:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
 <CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com>
 <87o6qjaiz7.fsf@osv.gnss.ru> <CAOMZO5BwoAzf36-L0uCTdKriGaUHg1MqZoKg56Fvob6S4coMBQ@mail.gmail.com>
 <87jz17afpb.fsf@osv.gnss.ru> <CAOMZO5Dvc9AhudPkEuM6BL7F4n=5S4M6d52jzomWnJvCOWVaaQ@mail.gmail.com>
 <87bjmih0nz.fsf@osv.gnss.ru> <CAOMZO5Cmxqq6K4k7_yPjGOtMTOgv7WmpN9O2dZiX+UWies8mow@mail.gmail.com>
In-Reply-To: <CAOMZO5Cmxqq6K4k7_yPjGOtMTOgv7WmpN9O2dZiX+UWies8mow@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 7 Oct 2025 18:44:01 -0300
X-Gm-Features: AS18NWDSo8bZWSU7ISvlQjLfCZQTzmIYDJk7SPT5Me8qC0gytjBsUsHrUVN_WdM
Message-ID: <CAOMZO5AJM-r-WnxcS4umg7_tzUemYGn3wt-_3ekG=VCot5PwAw@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 6:29=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:

> I saw Ulf's response about a potential regression in 6.17.
>
> Do you see the hang with 6.16?

Another suggestion: if your eMMC operates only at 3.3V, try passing
the "no-1-8-v" property for usdhc4.

