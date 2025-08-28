Return-Path: <linux-kernel+bounces-789244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87625B392B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91C63AA8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A4822576E;
	Thu, 28 Aug 2025 04:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPsMyCoN"
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55181625
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756356619; cv=none; b=UKAFo/r7f0jVffRQfsMNtPYQZpcY0n3ib4tMbbnZWO56t4XmNAR1My5SVEw2kLLs6m0kl5MlDGicfG3wOL4aAb4vKGg8Yx8HyUbmfcFiXFEI2cPBf8GHW4VDtH6UVEdJFWhG8AgJtGUaILo71OfboEORv9RUIywjAzar/lMEoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756356619; c=relaxed/simple;
	bh=GkTL7ptIOCtOYw/WcXmmg88Cm1Wk1G0BhUSsSk7xmmA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q6huV7Y1sgoyiNUWnCW/CeG3XRyZjTSZWrtPjrh/yR7lwCe0ADj3qN6I1UiI9yaAkCnYQy0eIKav09o/Lk9LvXI/ODduKpKdzXbzI9JbkpgOseHEqXAyR8Cr3xdsphfdp5ZDPdeO1kR9txZzOPTQ+IBT1z6C38uiy/zGiubXA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPsMyCoN; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e96b9022f51so379842276.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756356617; x=1756961417; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GkTL7ptIOCtOYw/WcXmmg88Cm1Wk1G0BhUSsSk7xmmA=;
        b=YPsMyCoNy/AajE5Cx+C6buu4rf4XkCshu8NshdCnnaMyQzRbIqH+gb5QQCpqj8YHel
         vZSlbp05L1MxZ1IIYHcaIoBnxSCVcE/Cr5Pk5YwaDX0p/jxhD3nIRStpZ8HY32UHSNz1
         WsCDKk3Ryh9wZi/PrMsObgbILAkdSAJBesBJNQIxOx0IFW09moUjPal/jrNhQhAWP3b4
         p0z8yqroaDNs/sgWcmYj3LSzA7O2WNFSHyefnFzuRRpew/vKQ8Gf3UBP0kpH0R9wxwk9
         De767BlDF3lGGztOMZVzUrXaUByPvfezK2lMDupldfsVDNajM1MpVxdFkvT+Aim0iyw0
         utdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756356617; x=1756961417;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkTL7ptIOCtOYw/WcXmmg88Cm1Wk1G0BhUSsSk7xmmA=;
        b=NjPFRqVz1MuE2Yy7iB4MufJJSnNEZBUXuwRoiOcKBTZ/gP2YPH4nDr6iElvL4k+zoi
         gLHxjA8GKd1nWtsl+oTe83ScKz1KZpvuXl+BnMfjlJ410WIYNETApL7PaZwf0VtwUYez
         DJ0gNgTc++L3vYDgFiNrR1nduvKhIm6ihx/jV0V6zff0iYx7pucbWkVp1Nb+xvPwJHN2
         u8ACSu1CrlnvRj2zMOm6bkfJ32puKx1//bsUCQXF62uyafzVxcbuvqi3g9ecnZfuNfUk
         yW3U8l5AeZkiBjpHUzVDhFr75prHMeozbEnPJvrM/DtYw5PHNOzPCpHLwKAABA9sPFUE
         FC1Q==
X-Gm-Message-State: AOJu0Yz54sbiCFtEdInFsu9Bbd4LxrfmHRUvxAsugr0IhtEtt60F+EvV
	Y9aT3+cJVsOt6bxwdzmgNVIPDzToqxpOgihZG1fwhVZtgovX/UE+PrTP0D/zoLtPAWT1sTbU+LF
	VEwincG+glJxoarL9eP4t+Nh9JMjtTuVAB6R6wk8=
X-Gm-Gg: ASbGncuc2rqBg1SItPSS8E0ivJVlrHobIHQtyDf+GNgemL0raTmep0PYbLOzXaloteg
	Df71Iy35cdkub/sodezPrEqaDhdofDkZZg95WYWN7zpNSzDjXgonLA0siDwrcctrfvxpO4756YR
	rB+AnrX2xEeZbtJXxxOZ3KKU3DgoFNxDTdBiKL5atePOVWTWT6ZmwcKmdxz+wslLIx9UYohGUNz
	GakQSrJ5XreptaP2iTE6X+q+XO7qNCu4JUezuxj3Q==
X-Google-Smtp-Source: AGHT+IEOmJhA81c2EcdAWsEOi7iISjvhpAqjZNsnUwVEGZNHkitaOAR9hKGRTV66vUFpnvBnEZaJD1NlMR06e66xoS8=
X-Received: by 2002:a05:6902:13cf:b0:e93:3d4b:40d2 with SMTP id
 3f1490d57ef6-e951c2e654fmr24623033276.15.1756356617250; Wed, 27 Aug 2025
 21:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Thu, 28 Aug 2025 10:20:06 +0530
X-Gm-Features: Ac12FXxOdYXLf_hiOkWuCwue7z2smQDb9cKoHx2rcvlX5N2kpb4UDP37AGKzMJE
Message-ID: <CAFf+5zgdRr=1a=AOJ9vc836X7Y8tvhxGqp3GLs7Amcd0ibfUPA@mail.gmail.com>
Subject: Bash script for taking backups of your files.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bash script for taking backups of your files.

-------------------
mybackup.sh
-------------------
--------------------------------------------------------------------
#!/bin/bash

backup_dir=~/backups

date=`date "+%Y-%m-%d-%H-%M-%S"`

set -x

cp $1 $backup_dir/$1.$date
--------------------------------------------------------------------

Example: ~/mybackup.sh myfile.c

----

