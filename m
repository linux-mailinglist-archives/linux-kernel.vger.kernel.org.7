Return-Path: <linux-kernel+bounces-805465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D737FB488DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A94C162086
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB82EFD86;
	Mon,  8 Sep 2025 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOfU7WIM"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA3292918
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324639; cv=none; b=IEa4WaJ9roiT29OfbFH7BUfkEGb6n6oEuf79Cd9NSPpBW6jBwgrCosZLkJBJ2GFGBBB5eNez6+Kdmh8VKBlrwDkAlNgEyXtBU/X9nAIh5wVsk4AnvExy3jB1KSkKB9ih2kRL1jxxF2drWx6++wfIR2Qzp+YZU0tfVLRjWH4p+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324639; c=relaxed/simple;
	bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UHEhL7bPk6gFdJi2oMLoxW2tM55Gy0yUtz6AL5qmTypb/C7XniDeHFb0GrxpzGo/OL81Z9yf6bfQjaetL4rJI//gjsCswKWRYMMK99m36yiYpn5hD+bKkeBkJN6o0H84XAgCny94HsYAGxsyaw1DfzqLKcreAk7k2Xm2ZNgP/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOfU7WIM; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-321289dee84so1053840fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757324636; x=1757929436; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=GOfU7WIMkem9rzizRxQnjAHvJzPs2HLa6v7tn50XlzgkcnfI44UOYjvqZLH5FrkZ6J
         swPvLyiLPMfXYIb1/nTk77cWtRJAQCTRWeDZ2C3UpJyig0/SH/XNPGecxjsMJ3H/y7Gs
         FxCLgnADb+ZgHoOlLYbTEUAb+X3/lpc+6LMEibD0+bhoUdn4d83IOofXX0yTqQUdgDCS
         t3dwVeMibt1vAiR+1pcDX0c1O4pZxzkC7MMODOv2HsSeAHaxFzxAxgvL39AMToxWlWMk
         inTbSTiSfr66iBGaBK8jTcyde4PcNEhdYJZqbAttjRxumndkJ0/rhE47TLhzgvYay39k
         g0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324636; x=1757929436;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=UhQMQHIsYgndwhcRGNUjukaCLvk+Q8Ih/ZFIpCY+PslZr3owIlNeIQznG/sLyTGnrL
         sWf3Hy0wK87muroKXzoICc2kvzxbE3ff6qOxjNtdwjEnbllFIYpkqubVcX3m6J7CO+8J
         Sor+Bvfv31B3a4hG0BGSytYXM7ANstZz+rO46RfW53YHIJDtOii18lFhJno9eG+JPCmg
         nWrvjb/K99lLQ3ssOyHVYqXsQVHqyrEir5FcLo9NFVTCSZgGo8ydlwnovU32DlYyt9gX
         ICNaNXCJCPo6hhQ3C52t/KWLFk41QuD227oNbio/BUQmuwR0MP4eFpN2OJz7tl39h78/
         HMrA==
X-Gm-Message-State: AOJu0YxgkkMwgOjlDBk1zAX6TtXQ7Mj0N2vQ8AhdDUEOLgnwIqMyklx+
	G96M5tEPXyJHgGsHdbFQTyeGqzLhGudzBQ9HccgWX7iZrylf/YZW0hKnvT8W1Qb4FbOLJ/On9Le
	bXZlEZpxMp2+aCM58II60IpYvYCtXe3/ITNNV
X-Gm-Gg: ASbGnctvfZYMiRdFqoaCifChQv9bm/4d7+jufd7ZHXD88PqLyXbsOlcH3VSSfYeXv0U
	IH2LH7A6xY7re1ot5OKKWAHS+VsuglmIamHEyVoExiM0+25DcWzYTx9GXrr4wDnyxKmt/G0Ch0n
	0/o+1CQ8gpqn6MG9kUYv5tr+l+UZFu/OXaHm419nH5oLDQbJBlP2taj1uM6d1pLQnhyEhmIOFzO
	m/VNzQX
X-Google-Smtp-Source: AGHT+IFj63o6MrJrnHE9xGEkRohiCYk2AI8gjNQNKQqLtp0VNMdpHmddlA8BGVgkm0CZyopI8kf5LwpKDmdetyW6xzo=
X-Received: by 2002:a05:6870:1b8f:b0:31d:8c33:59c0 with SMTP id
 586e51a60fabf-32264d19ad1mr4488609fac.29.1757324636627; Mon, 08 Sep 2025
 02:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: snow snow <snow.kevin748@gmail.com>
Date: Mon, 8 Sep 2025 17:43:45 +0800
X-Gm-Features: Ac12FXyIENtmH9UNJ5D_ZRNXgZCWuxv_-mSEWr0t7N7OOF8ZtPOKcqd_LINhLrc
Message-ID: <CA+DxC5UCmYdK545NYiVGmui=-aUeMwDDK7YTqdxwqWqzSkJ+Lg@mail.gmail.com>
Subject: 
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subscribe linux-kernel

