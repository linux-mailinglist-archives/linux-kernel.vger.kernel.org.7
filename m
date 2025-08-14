Return-Path: <linux-kernel+bounces-768156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423F5B25D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846451C82BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA724267AF2;
	Thu, 14 Aug 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RnS1aIBf"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89318F4A;
	Thu, 14 Aug 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156889; cv=none; b=r+QOdsHo4ki0swrsRRg8UcpSEfADnu+X3TiqABVxbMtwK4FU8G2voktkYfF+El+sNw/bXQ3UL5o+vVbSayXfvBTbuNnG86+QyocI+YKzz74MoGG5XWpE4zJcudf7Dm1qgJVvTu2kL4/WDb7iF6iBSOz1VGvmWQ7RjlBp1jZ4798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156889; c=relaxed/simple;
	bh=gb//sC3uVnfDkJjy2aiYiacPurthSFG/TQvxcS/O8Po=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=II84jPGW790VDftgaqPpN/pJOsCeZXBvx2xIoqdOoZ7kBGc2kPEIw0sw0o3oWUtbykdQ2q68o86N+67EknGncpra2JGQwgKwov5HBVVvxQXulLRGTfonqbVZZp7hS/HaHekqBHtkFRbJuc6euje2waPMQlkxOd9D5x6ttJQeECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RnS1aIBf; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0215444500;
	Thu, 14 Aug 2025 07:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755156884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5tAIsgzKuRELv1sm6eESXsPqoZSkkSUqkB2pMeL970=;
	b=RnS1aIBf3kPuNafBPr5O0T08jAPqeQ5PpdRcHNBXts4N2l7FzWgxEa6s2MzTJsWNvgoeJD
	rs8+UoZ/6KX/KVJx9TlJiusbzmgArqHlVRGeCLaSbEsBCU2HRcAMZ2Q5Qi8yQ9qqHxhaCY
	NQmY9HLvJ6a0YwkT+bGet4Q8QyI+Aj8y1e8qwovE6YeuPE7LJBJLThkwFB6wDIv/q3vUa2
	Y6BOmIXrewaucYGADm1kHYF/XC7OeNePDcd/Dn60VHLbxJgrXLJgPXdpZzOpr47yx6UAcQ
	3j7sr1Ocv7R9ogaltf0elyZxx3zqzbvSGBpnFIRzpAzDqPD8sZmkYmLXX95ChA==
Date: Thu, 14 Aug 2025 09:34:43 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 1/4] soc: fsl: qmc: Only set completion interrupt
 when needed
Message-ID: <20250814093443.1506b49f@bootlin.com>
In-Reply-To: <20250813120651.27dc8467@bootlin.com>
References: <cover.1754993232.git.christophe.leroy@csgroup.eu>
	<badb68a85910e5e6f1094ef3b01805209ac21854.1754993232.git.christophe.leroy@csgroup.eu>
	<20250813120651.27dc8467@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtgeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtkeertdertdejnecuhfhrohhmpefjvghrvhgvucevohguihhnrgcuoehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveeiffefgeeitdelleeigefhjeelueeuveekveetgeffheeltdekgeduiefggfdvnecukfhppedvrgdtudemtggstdekmeelkeeltgemkedttddtmehfugekudemleehgegvmedvudehrgemfeeluddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdtkeemleeklegtmeektddttdemfhgukedumeelheegvgemvdduhegrmeefledutddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtghpthhtohepqhhirghnghdriihhrghosehngihprdgtohhmpdhrtghpthhtohepshhhvghnghhjihhurdifrghnghesghhmrghilhdrtghomhdprhgtphhtthhop
 egiihhusghordfnvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhitgholhgvohhtshhukhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: herve.codina@bootlin.com

Hi Christophe,

On Wed, 13 Aug 2025 12:06:51 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi Christophe,
> 
> On Tue, 12 Aug 2025 12:50:55 +0200
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
> > When no post-completion processing is expected, don't waste time
> > handling useless interrupts.
> > 
> > Only set QMC_BD_[R/T]X_I when a completion function is passed in,
> > and perform seamless completion on submit for interruptless buffers.
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> > v2: Keep the UB flag to mark not completed buffers and seamlessly flag them as completed during next submit.
> > ---
> >  drivers/soc/fsl/qe/qmc.c | 44 ++++++++++++++++++++++++++++++----------
> >  1 file changed, 33 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> > index 36c0ccc06151f..8f76b9a5e385d 100644
> > --- a/drivers/soc/fsl/qe/qmc.c
> > +++ b/drivers/soc/fsl/qe/qmc.c
> > @@ -461,9 +461,16 @@ int qmc_chan_write_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
> >  
> >  	ctrl = qmc_read16(&bd->cbd_sc);
> >  	if (ctrl & (QMC_BD_TX_R | QMC_BD_TX_UB)) {
> > -		/* We are full ... */
> > -		ret = -EBUSY;
> > -		goto end;
> > +		if (!(ctrl & QMC_BD_TX_I) && bd == chan->txbd_done) {
> > +			if (ctrl & QMC_BD_TX_W)
> > +				chan->txbd_done = chan->txbds;
> > +			else
> > +				chan->txbd_done++;
> > +		} else {
> > +			/* We are full ... */
> > +			ret = -EBUSY;
> > +			goto end;
> > +		}
> >  	}
> >  
> >  	qmc_write16(&bd->cbd_datlen, length);
> > @@ -475,6 +482,10 @@ int qmc_chan_write_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
> >  
> >  	/* Activate the descriptor */
> >  	ctrl |= (QMC_BD_TX_R | QMC_BD_TX_UB);
> > +	if (complete)
> > +		ctrl |= QMC_BD_TX_I;
> > +	else
> > +		ctrl &= ~QMC_BD_TX_I;
> >  	wmb(); /* Be sure to flush the descriptor before control update */
> >  	qmc_write16(&bd->cbd_sc, ctrl);
> >    
> 
> You try to purge one descriptor for which the transfer is done but you do that
> when you have no more free descriptors.
> 
> You end up with all descriptor "used". I think a better way to do that is
> to purge all "done" descriptor configured to work without interrupts until a
> descriptor with interrupt is found.

I have looked again at your code and looking for a free descriptor only when it
is needed is sufficient. You can forget my previous proposal.

Back to your code, I think you need to be sure that the descriptor you want to
re-use is really available and so you need to check the 'R' bit to be sure
that we are not with 'R' = 1 and 'UB' = 1 which means "BD is used, waiting for
a transfer".

For instance:

	if (ctrl & (QMC_BD_TX_R | QMC_BD_TX_UB)) {
		if (!(ctrl & (QMC_BD_TX_I | QMC_BD_TX_R) &&
		    bd == chan->txbd_done) {
			if (ctrl & QMC_BD_TX_W)
				chan->txbd_done = chan->txbds;
			else
				chan->txbd_done++;
		} else {
			/* We are full ... */
			ret = -EBUSY;
			goto end;
		}
	}

Best regards,
Hervé

