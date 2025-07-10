Return-Path: <linux-kernel+bounces-725304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C1DAFFD55
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C725A6C01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E865E2C1591;
	Thu, 10 Jul 2025 08:58:10 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837F28C2B8;
	Thu, 10 Jul 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137888; cv=none; b=rqMa1FzUun+iATlkPQ4zgWFQbm1xeKVed7Y53emTxKfzfWQlrFgfiC2dDL9BbceVxaI5h2S3S6Ol3r8my5hAW7IP32IeQnde5Emo3CN7PxVfLwStjMLKlm660FlyUeWrs5OHmwWV3M27GiUcyDHwtYu+howLIFHJD48nnuc7j5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137888; c=relaxed/simple;
	bh=RM3YKeLusyoIxA65deexSAfRfPCCIUZjw3I3SLrLrqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOD29fTz7xSV0Woetjr9EKHZIRtfq84euzStpV0OuyHH6FAozTNebUy7lVoYlqIL7V/Ojok3RKVbtWRJxJdFe/mSqPHYm06CNWGzlqCl4/ZNTmrv79D52Jk06PYG8HypRuc2W4LA6x6QO3j25QhELTJBSrAbbz4x7Uu6fibNnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpgz16t1752137825tfbeab483
X-QQ-Originating-IP: Ir1sU2IXxDKEZbld2UFPSluSo1bTYuvOxet/oCwtRCI=
Received: from localhost ( [183.17.231.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 16:57:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5788280121000052774
EX-QQ-RecipientCnt: 13
Date: Thu, 10 Jul 2025 16:57:03 +0800
From: Nick Li <nick.li@foursemi.com>
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
	xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com,
	like.xy@foxmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ASoC: codecs: Add FourSemi FS2104/5S audio
 amplifier driver
Message-ID: <61B23934F28A9F2C+aG-AXznikkHb2_jR@foursemi.com>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-5-nick.li@foursemi.com>
 <aG5Smt_DErSq5WjE@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aG5Smt_DErSq5WjE@finisterre.sirena.org.uk>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NwZEY09ZZGEZUnkMjvMj+oS4opMKYYBsjGS32BrE11Fp9ay8idIQljgy
	cDghGxLwTQ2HsPNQ+p1yJf4aUCiIMcZMldK2esBfmRutetJgt6l4UFQIG5jIoeRtmB1V9/8
	N9Y6MEyvF/R+fnkkkwKo/VbiCGbZcvwCQLZD/m45dH+gymE+Oj3JVSBGFOytyhQqoJqdXvY
	Co8zgC2RN0Z9xWIHNciT0YWcu25OdXstrlygXC8hC7OE7TodrobutSZIABlbK0/f2bYsp8z
	Ohi+jWMSYy2snw8ekWjb+vNXEfSvI/c+3LNecFyl7kUsbCP1mxsnFGUSg8pT/Ghy9TUFQRM
	Xu7jD2wcFmzV9EgsFLJueQDG3o3NTEXyVJU6d3LoXMzo+fliW9rNta3LzNGtSw/rtAOLTo/
	fa7UK73rXmVmmaKDVdlmrUT7VvI0cDuNmtqnda5OPUQp1fK9lNNbxp8jCv4MWZLbYo/sygj
	5F8NDDWUcJ9hOEMBm9qdYagvf/X0fwO7AFP5UeeRCbqm4HMPRi6Hl0n2NBpU0/qHvlKLVqv
	U9Yux+hDIwVA8KAqx73Qb5YhsPVHgpTUv0OLuAu1fAqTI6GEJfbKtSrFMJyojsh2BQlc3U1
	+UPB6SwtytPYIERflKfZ6GnIipB4e8hACHwB1WR9sIop64ZF1BADSp34dT+xGsto64wm1Pl
	wcNOWTZ+fMUDgJ2cqV7e8HsSkpUrKHu3vDZ2+47wWAN3Hcj6XIOtLhbyf11GChBcwofxWyo
	cyjLfl/tVw5nZ2d72qu8JQr6g0etc/AKOkHXaj/JE9bTHBktnt4nkQH+HHZo66WvhoMSOTd
	eZ3qb6x7RroKtXm2QfbxgSF2FTYlKiZvygJzEKiZXDa9Fk5BY7sfTTx4LRhnIncDpCtl+Yn
	cRJOskcvAd5o2JNl17po/frxEXxUat/SoflHWAkmOheW5bgfu/y+2rQP3FaobDgLYKmHJEF
	wTWZLcKxw/l+PqrlXSGfEZXY/fDnf7oVAqOGMUn27lybVncNWzls0bqQRb4l7msDGCZ7heE
	BHE42hHhhhMPq29b1s7TYoUHqU8TXWgQVj55g/Sm7LShoSecyFwEKakgIQDaE=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Wed, Jul 09, 2025 at 12:29:30PM +0100, Mark Brown wrote:
> On Tue, Jul 08, 2025 at 07:29:01PM +0800, Nick Li wrote:
> 
> > The FS2104/5S are FourSemi digital audio amplifiers
> > with I2C control. They are Inductor-Less, Stereo, Closed-Loop,
> > Digital Input Class-D Power Amplifiers with Enhanced Signal Processing.
> 
> This looks broadly OK - there's a few more fairly small issues below in
> addition to those that Krzysztof flagged.
> 
> > +static int fs210x_set_pcm_volume(struct fs210x_priv *fs210x)
> > +{
> > +	u16 vol[2];
> > +	int ret;
> > +
> > +	if (fs210x->devid == FS2105S_DEVICE_ID) {
> 
> A swtich statement is better style here, it makes it easier to add more
> variants.

Good idea.

> 
> > +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> 
> _CLOCK_PROVIDER_MASK
> 
> > +	case SND_SOC_DAIFMT_CBC_CFC:
> > +		/* Only supports slave mode */
> 
> consumer mode.

You had metioned in v1, will fix next version.

> 
> > +		dev_err(fs210x->dev, "Only supports slave mode\n");
> 
> consumer mode.

Got it.

> 
> > +static int fs210x_dai_hw_params(struct snd_pcm_substream *substream,
> > +				struct snd_pcm_hw_params *params,
> > +				struct snd_soc_dai *dai)
> > +{
> > +	struct fs210x_priv *fs210x;
> > +	int chn_num;
> > +	int ret;
> > +
> > +	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
> > +		return 0;
> 
> There's no configuration for capture?  Should the driver be setting
> symmetric_rates and then not reconfiguring if active instead, it looks a
> lot like the driver is relying on userspace starting playback before
> capture to configure?

In capture path:
The device can output EC reference signal for AEC,
it can't output the signal without playing audio(start device in playback).
We had set symmetric_rates = 1 in fs210x_dai

> 
> > +static int fs210x_pcm_volume_put(struct snd_kcontrol *kcontrol,
> > +				 struct snd_ctl_elem_value *ucontrol)
> > +{
> 
> > +	fs210x->vol[0] = (u16)*pval;
> > +	fs210x->vol[1] = (u16)*(pval + 1);
> > +	dev_dbg(fs210x->dev, "Set volume: %d-%d\n",
> > +		fs210x->vol[0], fs210x->vol[1]);
> > +
> 
> The driver should return 1 if there's a change in the values and 0
> otherwise (plus it can skip a bunch of work if there's nothing to do).
> 
> The mixer-test test will spot this for you.

BTW, what's the mixer-test? We tested it by using alsamixer and amixer.

> 
> > +static int fs210x_effect_scene_put(struct snd_kcontrol *kcontrol,
> > +				   struct snd_ctl_elem_value *ucontrol)
> > +{
> 
> > +	ret = fs210x_set_scene(fs210x, scene_id);
> > +	if (ret)
> > +		dev_err(fs210x->dev, "Failed to set scene: %d\n", ret);
> > +
> > +	mutex_unlock(&fs210x_mutex);
> > +
> > +	return ret;
> 
> Same issue with flagging changes.

Got it, we will update what you mentioned in here and previous mail,
the next version may need to test for a few days, I'm sorry for my late response.

Thanks.

Best regards,
Nick




