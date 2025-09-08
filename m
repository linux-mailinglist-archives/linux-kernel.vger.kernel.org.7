Return-Path: <linux-kernel+bounces-805370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C798B487B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F91D188B9D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF57B2E88B6;
	Mon,  8 Sep 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV2GNTfi"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359B29AAFD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322124; cv=none; b=D3MJ6L+2V7vaAGJCdYHWoKMD6b/CNl9IewZ89Hh/2+7SNXswP9deAB1wkvb9GGywjhBHeiKLuZziASf9yReBsX0Be2j2kbz4xZ2QQtJbu3t+EASrgo0S/yE6ZAai4kt80fapflyBlXmJeUJnGbF06SjjelU2X40JRi6SlkR13GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322124; c=relaxed/simple;
	bh=vltsvOFp04Vg3uSno3w6rx0Mhfwe4pqKVFBGIA2Z17o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LtulaoMarvC/nMpd92mwz18UjvL2xIQnbaQQzuYKYBq+QZBWh98NnOeg7EY4GMyvZksb7spipZXjwyqnrsojc4qwbMMF3K0UG1Ai9MlD3PJdZxPxpM8OqF3I6gvx3BhveGLhditaBpJQx3P9DYoeemvByp27B9iGprDgOZrd7Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV2GNTfi; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-62177413b39so955279eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757322122; x=1757926922; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vltsvOFp04Vg3uSno3w6rx0Mhfwe4pqKVFBGIA2Z17o=;
        b=MV2GNTfiw3Gu+QwEdoDl1aN0QKtMfvDcqJiMOWnfQ4ipLic/viNfHVU1D4S5qLzVlh
         +YACUgh0Op45KgxFalxewaj6yrjoryfmHMQoEZQnQoIHdQyZ3Tnl9UBeWgzPcrvUkrh0
         KQLGmO7elOW97t1+6Xwh1D/ziMc6t64FJlj/JAFdAShYKmk24eLYyDY+3EggnpOiuoM/
         1aK+sUBeAjzrjasXfwRsP+5XCYZ771+dYl8vfd0TEHBLXvg7+2DDG6QdXPxpIses6DR3
         Tlx8wBiJsqHjXoMRWACbbNcK6zCtdsvy6zgPr2pb0U7bNuPCoVT/gXPGhdjdGa6XT3L3
         1zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757322122; x=1757926922;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vltsvOFp04Vg3uSno3w6rx0Mhfwe4pqKVFBGIA2Z17o=;
        b=GXneogtvHzxkcld/Ip5zQ/tapXOsBOB4WNbg4wkjQRyHe/sQL0nRwcFi0O8cEXPqjc
         qcVDV+uFtaav6oYl81BvARxMOO8j//Xc1CcFQsnn+QVOmGLi/hZxO6gMwY8o183U9pTg
         eefKVcYFtYLMNtOvUTgej57CMtFnTpPSYBY2FUY4yQU2RbZMcMtFkLU3d/wJh2hBIhg6
         xT0LJirW9w8VaRSH2yAupogNyMynEjcdVsL0s/bSK927+IK8rgf/PaYYJgp2j2me0nRZ
         vmQb777BLZKLwBU1JkDTxOwr+GwSnB+wCQLtsftHL7UTuBP41vDY2qlF7auwR/2WYPSd
         psLw==
X-Gm-Message-State: AOJu0YxTN+KVcpzdxJ2TPdDp1p8ZOd6B4OpKlYnbk9oD9/Ymb75OFPQy
	xbpN0FLt3QCrrMFpdWpzhr9rOeKwtJ3zy5Hx0Qxw3Udfp2xfUaq54shdx1oo4ywTLSr1oPLgwZG
	ntKkiQSw6B4nNhj3Gxb3NhvQy4Zo6mz3uUMgY
X-Gm-Gg: ASbGncvvideCHh3EEKDXDa3yKG6OR3ecWqwC1bolln2mz7maujX6/M1bQjc4/CPnRjA
	ERH+3agtWc1f47YLRXpAWmxMMdUZrGOEwE9NuuBfI5ar5vBqJUPp/Jo/kfCKDPxMWh/yTb5+ect
	fxHnu6deAGwwoG+z1GWhnMXvX/FMZq79/djY4vHuBKTTGz1ZUCXkL8MTOmvt4nHoBbSSd+KydDU
	v+a/qzO
X-Google-Smtp-Source: AGHT+IGAY8EpkLQFh8R5F3ioZlZFzdg/8dNlMXkSJqTH77dLAECSB9dvOd/VADLOiDobY/9spT1gQEsTPZ6a34B5TZU=
X-Received: by 2002:a05:6870:701f:b0:2ff:a513:26dd with SMTP id
 586e51a60fabf-3226274006dmr3626974fac.6.1757322121980; Mon, 08 Sep 2025
 02:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: snow snow <snow.kevin748@gmail.com>
Date: Mon, 8 Sep 2025 17:01:51 +0800
X-Gm-Features: Ac12FXzlOL9rTwXC0PYc_6D05lK2Lvtn-JObgJMiUYLN2d__ENe42poj0Pk5Awc
Message-ID: <CA+DxC5U9VDiFZLAsYHfvPdHxxG6xQWwgFaH+4AgTWs9n=_-+6g@mail.gmail.com>
Subject: 
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subscribe linux-kernel snow.kevin748@gmail.com

